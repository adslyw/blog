class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :destroy]
  # GET /microposts
  # GET /microposts.json
  def index
    @user = User.find(params[:user_id])
    @microposts = Micropost.where(user_id: params[:user_id]).paginate(page: params[:page],per_page: 6)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microposts }
    end
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
    @micropost = Micropost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @micropost }
    end
  end

  # GET /microposts/new
  # GET /microposts/new.json
  def new
    @micropost = current_user.microposts.build if signed_in?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropost }
    end
  end

  # GET /microposts/1/edit
  # def edit
  #   @micropost = Micropost.find(params[:id])
  # end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = current_user.microposts.build(params[:micropost])

    respond_to do |format|
      if @micropost.save
        flash[:success] = 'Micropost was successfully created.'
        format.html { redirect_to current_user }
        format.json { render json: @micropost, status: :created, location: @micropost }
      else
        flash[:danger] = 'Micropost was not successfully created.'
        format.html { render action: 'new' }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /microposts/1
  # PUT /microposts/1.json
  # def update
  #   @micropost = Micropost.find(params[:id])

  #   respond_to do |format|
  #     if @micropost.update_attributes(params[:micropost])
  #       format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @micropost.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    flash[:success] = "Destroyed successfully!"
    respond_to do |format|
      format.html { redirect_to user_microposts_url }
      format.json { head :no_content }
    end
  end

end
