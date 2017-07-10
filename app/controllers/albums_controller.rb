class AlbumsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource through: :user

  def new
    @album = Album.new
  end

  def show
    @tags = @album.tags
    @photos = @album.photos
  end

  def edit
  end

  def update
    @album.tags = TagService.new(params[:album][:tags]).tags
    if @album.update_attributes(album_params)
      flash[:success] = "Album updated"
      redirect_to [@user, @album]
    else
      render 'edit'
    end
  end

  def create
    @album = @user.albums.create(album_params)
    @album.tags = TagService.new(params[:album][:tags]).tags
    if @album.save
      flash[:success] = "Album created!"
      redirect_to [@user, @album]
    else
      redirect_to @user
    end
  end

  def destroy
    if @album.destroy
      flash[:success] = "Album deleted"
    end
    redirect_to @user
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end
end
