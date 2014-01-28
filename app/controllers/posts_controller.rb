class PostsController < ApplicationController
	before_filter :signed_in_user, only: [:new,:create, :update, :destroy] 
  def new
  	@post = Post.new
    @user = current_user
  end
  def create
  	@user = current_user
  	@post = @user.posts.create(params[:post])
  	redirect_to user_path(@user)
  end

  def show
  	@post = Post.find(params[:id])
  	respond_to do |format|
  		format.html # show.html.erb
    	format.json { render json: @post }
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(user_id: params[:user_id]).paginate(page: params[:page],per_page: 4)
  	respond_to do |format|
  		format.html
  		format.json { render json: @posts}
  	end
  end
  def update
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Destroyed successfully!"
    respond_to do |format|
      format.html { redirect_to user_posts_url }
      format.json { head :no_content }
    end
  end
end
