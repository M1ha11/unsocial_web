class AlbumsController < ApplicationController
  before_action :user
  load_and_authorize_resource

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def show
    @album = user.albums.find(params[:id])
    @tags = @album.tags
    @photos = @album.photos
  end

  def edit
    @album = user.albums.find(params[:id])
  end

  def update
    @album = user.albums.find(params[:id])
    @album.tags = TagService.new(params[:album][:tags]).tags
    if @album.update_attributes(album_params)
      flash[:success] = "Album updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def create
    @album = user.albums.create(album_params)
    @album.tags = TagService.new(params[:album][:tags]).tags
    if @album.save
      flash[:success] = "Album created!"
      redirect_to [user, @album]
    else
      render 'home_page#index'
    end
  end

  def destroy
    if @album.destroy
      flash[:success] = "Album deleted"
    end
    redirect_to root_url
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
