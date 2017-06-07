class UsersController < ApplicationController

  # GET /Users
  # GET /Users.json
  def index
    @users = User.all
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
    @user = User.find(params[:id])
    @album = @user.albums
  end

  # GET /Users/new
  def new
    @user = User.new
  end

  # GET /Users/1/edit
  def edit
  end

  # POST /Users
  # POST /Users.json
  def create
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
  end

  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
  end
end
