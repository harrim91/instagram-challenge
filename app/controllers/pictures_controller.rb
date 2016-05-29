class PicturesController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?
    @pictures = Picture.all
    flash[:notice] = 'No pictures available' if @pictures.empty?
  end

  def show
    @picture = Picture.find params[:id]
  end

  def new
  end

  def create
    @picture = Picture.create(picture_params)

    if @picture.save
      redirect_to pictures_path
    else
      flash[:notice] = 'There were errors uploading the picture'
      render 'new'
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:image, :description)
  end
end
