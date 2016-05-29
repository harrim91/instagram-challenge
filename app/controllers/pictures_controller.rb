class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
    flash.now[:notice] = 'No pictures available' if @pictures.empty?
  end

  def show
  end

  def new
    # @picture = current_user.pictures.build picture_params
  end

  def edit
    unless current_user == @picture.user
      flash[:alert] = 'Only the picture owner can edit'
      redirect_to pictures_path
    end
  end

  def create
    @picture = current_user.pictures.build picture_params

    if @picture.save
      redirect_to pictures_path
    else
      flash.now[:alert] = 'There were errors uploading the picture'
      render 'new'
    end
  end

  def update
    @picture.update picture_params
    redirect_to picture_path @picture
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path
  end

  private
  def picture_params
    params.require(:picture).permit(:image, :description)
  end

  def set_picture
    @picture = Picture.find params[:id]
  end
end
