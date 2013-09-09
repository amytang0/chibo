class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  skip_before_filter :verify_authenticity_token, :only => [:vote_up, :vote_down]
  load_and_authorize_resource :except => :create

  def new
    @post = Post.new
    @post.user = current_user
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
#    @posts = Post.all
    @posts = Post.plusminus_tally.page(params[:page]).per(2)
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

  def vote_up

    begin
      current_user.vote_exclusively_for(@post = Post.find(params[:id]))
      Rails.logger.info "Voted up"
      render partial: 'votecount', locals: {post: @post} 
      flash[:success] = "You have voted successfully"
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "You have already voted"
      render :nothing => true, :status => 404
    end
  end

  def vote_down
    begin
      current_user.vote_exclusively_against(@post = Post.find(params[:id]))
      render partial: 'votecount', locals: {post: @post} 
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end



  private
    def post_params
      params.require(:post).permit(:title, :whitetext, :blacktext)
    end

end
