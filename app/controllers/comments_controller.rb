class CommentsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :album, through: :user
  load_and_authorize_resource :photo, through: :album
  load_and_authorize_resource through: :photo

  def create
    @comment.user = current_user
    Notifications::NotifyComment.new(@comment).notify if @comment.save
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
