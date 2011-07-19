class CommentsController < ApplicationController
  before_filter :get_parent

  def create
    @comment = @parent.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to post_path(@parent)
    else
      render :new
    end
  end
  
  def destroy
    @comment.destroy
    redirect_back_or root_path
  end
  
  def index
    @comments = @parent.comments
  end

  protected

    def get_parent
      @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
      @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]

      redirect_to root_path unless defined?(@parent)
    end
    
    def get_post(thing)
      return unless @parent.class == Post
      @parent = @parent.get_parent
      get_post(thing)
    end
end
