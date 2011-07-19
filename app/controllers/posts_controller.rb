class PostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def new
    @title = "Speak"
    @post = Post.new
  end
  
  def create
    @post  = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      @feed_items = [ ]
      render 'pages/home'
    end
  end

  def destroy
    @post.destroy
    redirect_back_or root_path
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
    @title = @post.user.name + ' | ' + @post.title
  end
  
  def edit
    @title = "Edit post"
    @post = Post.find(params[:id])
  end
  
  def update
    @post = current_user.posts.find_by_id(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated."
      redirect_to @post
    else
      @title = "Edit post"
      render 'edit'
    end
  end
  
  private

    def authorized_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_path if @post.nil?
    end
end