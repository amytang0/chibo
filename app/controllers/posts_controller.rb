class PostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => :create

  def new
    @post = Post.new
    @post.user = current_user
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def destroy
    Rails.logger.info "Called destroy"
    @post = Post.find(params[:id])
    @post.destroy
    @post.comments.destroy

    redirect_to posts_path
  end

  def create
    @post = Post.new(params[:post].permit(:title, :whitetext, :blacktext))
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:title, :whitetext, :blacktext))
      redirect_to @post
    else
      render 'edit'
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :whitetext, :blacktext)
    end

end
