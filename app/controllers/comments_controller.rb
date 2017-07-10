class CommentsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :album, through: :user
  load_and_authorize_resource :photo, through: :album
  load_and_authorize_resource through: :photo

  def create
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Success comment"
      Notifications::NotifyComment.new(@comment).notify
    else
      flash[:alert] = "Error comment"
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
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
end
