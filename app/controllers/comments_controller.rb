class CommentsController < ApplicationController
  before_filter :get_parent

  def new
    @comment = @parent.comments.build
  end

  def create
    @comment = @parent.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comment created!"
    end
    redirect_to @comment.post
  end
  
  def destroy
    @post = @comment.post
    @comment.destroy
    redirect_to @post
  end

  protected

  def get_parent
    @parent = Post.find(params[:post_id]) if params[:post_id]
    @parent = Comment.find(params[:comment_id]) if params[:comment_id]

    redirect_to root_path unless defined?(@parent)
  end
end