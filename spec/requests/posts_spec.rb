require 'spec_helper'

describe "Posts" do

  before(:each) do
    user = Factory(:user)
    integration_sign_in(user)
  end
  
  describe "creation" do
    
    describe "failure" do
    
      it "should not make a new post" do
        lambda do
          visit root_path
          fill_in :post_title, :with => ""
          fill_in :post_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Post, :count)
      end
    end

    describe "success" do
  
      it "should make a new post" do
        title = "This is a title"
        content = "This is some meaningful text."
        lambda do
          visit root_path
          fill_in :post_title,   :with => title
          fill_in :post_content, :with => content
          click_button
          response.should have_selector("span.title",   :content => title)
          response.should have_selector("span.content", :content => content)
        end.should change(Post, :count).by(1)
      end
    end
  end
  
  describe "destruction" do
    
    it "should not have delete links for other users' posts" do
      other_user = Factory(:user, :name => "Bob", :email => "another@example.com")
      get "/users"
      click_link "Bob"
      response.should_not have_selector("a", :content => "delete")
    end
  end
end