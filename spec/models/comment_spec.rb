require 'spec_helper'

describe Comment do
  
  before do
    @user = Factory(:user)
    @post = @user.posts.create(:title => "value for title",
                               :content => "value for content")
    @post.save
    @attr = { :content => "value for content" }
  end
    
  it "should create a new instance given valid attributes" do
    @post.comments.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @comment = @post.comments.create(@attr)
      @comment.user = @user
    end

    it "should have a user attribute" do
      @comment.should respond_to(:user)
    end

    it "should have the right associated user" do
      @comment.user_id.should == @user.id
      @comment.user.should == @user
    end
  end
    
  describe "parent associations" do

    before(:each) do
      @comment = @post.comments.create(@attr)
      @reply = @comment.comments.create(@attr)
    end
      
    it "should have a post attribute" do
      @comment.should respond_to(:post)
    end
    
    it "should find the root post if it's the direct parent" do
      @comment.post.should == @post
    end
    
    it "should find the root post even if it's several levels up" do
      comment3 = @reply.comments.create(@attr)
      comment3.post.should == @post
    end
    
    it "should cache the result in an instance variable" do
      @comment.post.should == @post
      @comment.should_receive(:commentable).never
      @comment.post.should == @post
    end
  end
end