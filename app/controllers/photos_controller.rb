class PhotosController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :album, through: :user
  load_and_authorize_resource through: :album

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
  end

  def update
    @photo.tags = TagService.new(params[:photo][:tags]).tags
    if @photo.update_attributes(photo_params)
      flash[:success] = "Photo updated"
      redirect_to @photo
    else
      render 'edit'
    end
  end

  def create
    @photo = @album.photos.create(photo_params)
    @photo.tags = TagService.new(params[:photo][:tags]).tags
    if @photo.save
      flash[:success] = "Photo created!"
      redirect_to [@user, @album, @photo]
    else
      redirect_to [@user, @album]
    end
  end

  def destroy
    if @photo.destroy
      flash[:success] = "Photo deleted"
    end
    redirect_to request.referrer || root_url
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :description)
  end
end
