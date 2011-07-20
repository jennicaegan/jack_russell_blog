class CommentsController < ApplicationController
  before_filter :get_parent
  before_filter :post, :only => [:create, :destroy]

  def new
    @title = "Speak"
    @comment = Comment.new
  end
  
  def create
    @comment = @parent.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
    end
  end
  
  def destroy
    @comment.destroy
    redirect_back_or post_path(@post)
  end

  protected

    def get_parent
      @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
      @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]

      redirect_to root_path unless defined?(@parent)
    end
    
    def post
      return @post if defined?(@post)
      @post = commentable.is_a?(Post) ? commentable : commentable.post
    end
end