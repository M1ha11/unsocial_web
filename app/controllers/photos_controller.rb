class PhotosController < ApplicationController
  before_action :user, :album
  load_and_authorize_resource

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def show
    @comments = @photo.comments
    @tags = @photo.tags
    respond_to do |format|
      format.html
      format.js
    end
    render action: 'show', layout: false if request.xhr?
  end

  def edit
    @photo = @album.photos.find(params[:id])
  end

  def update
    @photo = @album.photos.find(params[:id])
    if @photo.update_attributes(photo_params)
      flash[:success] = "Photo updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def create
    @photo = @album.photos.create(photo_params)
    @photo.tags = TagService.new(params[:photo][:tags]).tags
    if @photo.save
      flash[:success] = "Photo created!"
      redirect_to root_path
    else
      render 'home_page#index'
    end
  end

  def destroy
    @photo = @album.photos.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo deleted"
    end
    redirect_to request.referrer || root_url
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :description, :user_id, :album_id)
  end

  def user
    @user = User.find(params[:user_id])
  end

  def album
    @album = @user.albums.find(params[:album_id])
  end
end
