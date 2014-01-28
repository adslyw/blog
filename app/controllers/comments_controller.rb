class CommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  def create
    @post = Post.find(params[:post_id])
    params[:comment][:user_id] = current_user.id
    @comment = @post.comments.create(params[:comment])    
    redirect_to post_path(@post)
  end
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
end
