class CommentsController < ApplicationController
  before_action :find_user
  before_action :find_album
  before_action :set_photo

  def create
    @comment = @photo.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Success comment"
    else
      flash[:alert] = "Error comment"
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @comment = @photo.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "Success deleted"
    else
      flash[:alert] = "Error deleting"
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_photo
      @photo = Photo.find(params[:photo_id])
    end

    def find_user
      @user = User.find(params[:user_id])
    end

    def find_album
      @album = @user.albums.find(params[:album_id])
    end
end
