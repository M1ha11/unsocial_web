class AlbumsController < ApplicationController
  # before_action :correct_user,   only: :destroy
  before_action :find_user

  def index
    # @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def show
    # @album = current_user.albums.find(1)
  end

  def edit
  end

  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      flash[:success] = "Album created!"
      redirect_to root_url
    else
      render 'home_page#index'
    end
  end

  def destroy
    @album = @user.albums.find(params[:id])
    if @album.destroy
      flash[:success] = "Album deleted"
    end
    redirect_to request.referrer || root_url
  end

  private

    def album_params
      params.require(:album).permit(:title, :description)
    end

    def find_user
      @user = User.find(params[:user_id])
    end

    # def correct_user
    #   @album = current_user.albums.find_by(id: params[:id])
    #   redirect_to root_url if @album.nil?
    # end
end
