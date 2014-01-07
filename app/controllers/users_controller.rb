class UsersController < ApplicationController
  before_filter  :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter  :correct_user,   only: [:edit, :update]
  before_filter  :admin_user, only:[:destroy]
  # GET /users
  # GET /users.json
  def index
     @users = User.paginate(page: params[:page],per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        sign_in @user
        flash[:success] = "Aha wlecome #{@user.name}!"
        format.html { redirect_to @user }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to @user }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User destroyed."
    respond_to do |format|
      format.html { redirect_to users_url}
      format.json { head :no_content }
    end
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        flash[:danger] = "Please sign in."
        redirect_to signin_path
      end        
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "You don't have the permition to do that."
        redirect_to root_path
      end      
    end

    def admin_user
      unless  current_user.admin?
        flash[:danger] = "Permission denied."
        redirect_to users_path 
      end
    end
end
