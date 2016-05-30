class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture
  before_action :set_comment, only: [:destroy]
  before_action :check_if_owner, only: [:destroy]

  def create
    @comment = @picture.comments.build(comment_params)
    @comment.save
    respond_to do |format|
      format.html { redirect_to picture_path @picture }
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to picture_path @picture }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def set_picture
    @picture = Picture.find params[:picture_id]
  end

  def set_comment
    @comment = Comment.find params[:id]
  end

  def check_if_owner
    unless current_user == @comment.user
      flash[:alert] = 'Only the comment owner can delete'
      redirect_to picture_path(@picture)
    end
  end
end