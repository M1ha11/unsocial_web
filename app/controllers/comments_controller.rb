class CommentsController < ApplicationController
  before_action :find_user
  before_action :find_album
  before_action :set_photo

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @photo.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Success comment"
      redirect_to :back
    else
      flash[:alert] = "Error comment"
      render root_path
    end
  end

  def destroy
    @comment = @photo.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to :back
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
