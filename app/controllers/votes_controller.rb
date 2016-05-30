class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture

  def like
    @picture.liked_by current_user
    respond_to do |format|
        format.html { redirect_to picture_path @picture }
        format.js
    end
  end

  def unlike
    @picture.unliked_by current_user
    respond_to do |format|
        format.html { redirect_to picture_path @picture }
        format.js
    end
  end

  private
  def set_picture
    @picture = Picture.find params[:id]
  end
end
