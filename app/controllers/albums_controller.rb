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
    @album.update_attributes(album_params)
    @album.tags = TagService.new(params[:album][:tags]).tags
    album_respond
  end

  def create
    @album.tags = TagService.new(params[:album][:tags]).tags if @album.save
    album_respond
  end

  def destroy
    @album.destroy
    respond_with @album, location: -> { user_path(@user) }
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end

  def album_respond
    respond_with @album, location: -> { user_album_path(@user, @album) }
  end
end
