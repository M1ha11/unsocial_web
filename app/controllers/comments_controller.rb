class CommentsController < ApplicationController
  before_action :user, :album, :photo
  load_and_authorize_resource

  def create
    @comment = @photo.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Success comment"
      ActivityChannel.broadcast_to(@comment.photo.album.user, { text: @comment.content })
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

    def photo
      @photo = Photo.find(params[:photo_id])
    end

    def user
      @user ||= User.find(params[:user_id])
    end

    def album
      @album = @user.albums.find(params[:album_id])
    end
end
