class PicturesController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?
    @pictures = Picture.all
  end

  def new
  end

  def create
    @picture = Picture.create(picture_params)
    redirect_to pictures_path
  end

  private
  def picture_params
    params.require(:picture).permit(:image, :description)
  end
end
