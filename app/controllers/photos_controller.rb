class PhotosController < ApplicationController
  # before_action :correct_user,   only: [:destroy, :edit]
  before_action :find_user
  before_action :find_album

  load_and_authorize_resource

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def show
    @comments = @photo.comments
  end

  def edit
    @photo = @album.photos.find(params[:id])
  end

  def update
    @photo = @album.photos.find(params[:id])
    if @album.update_attributes(album_params)
      flash[:success] = "Photo updated"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def create
    @photo = @album.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo created!"
      redirect_to current_user
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
      params.require(:photo).permit(:image, :name, :description, :user_id, :album_id)
    end

    def find_user
      @user = User.find(params[:user_id])
    end

    def find_album
      @album = @user.albums.find(params[:album_id])
    end

    def correct_user
      @album = current_user.albums.find(params[:id])
      redirect_to root_url if @album.nil?
    end
end
