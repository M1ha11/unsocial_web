class PhotosController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :album, through: :user
  load_and_authorize_resource through: :album

  def new
    @photo = Photo.new
  end

  def show
    @comments = @photo.comments.includes(:user)
    @tags = @photo.tags
  end

  def edit
  end

  def update
    @photo.update_attributes(photo_params)
    @photo.tags = TagService.new(params[:photo][:tags]).tags
    photo_respond
  end

  def create
    @photo.tags = TagService.new(params[:photo][:tags]).tags if @photo.save
    photo_respond
  end

  def destroy
    @photo.destroy
    photo_respond
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :description)
  end

  def photo_respond
    respond_with @photo, location: -> { user_album_path(@user, @album) }
  end
end
