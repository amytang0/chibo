class CommentsController < ApplicationController
  load_and_authorize_resource :except => :create
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:body))
    @comment.user = current_user
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:body))
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

end
