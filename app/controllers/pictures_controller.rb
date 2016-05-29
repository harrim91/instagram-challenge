class PicturesController < ApplicationController
  before_action { redirect_to new_user_session_path unless user_signed_in? }
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
    flash[:notice] = 'No pictures available' if @pictures.empty?
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @picture = Picture.create(picture_params)

    if @picture.save
      redirect_to pictures_path
    else
      flash[:alert] = 'There were errors uploading the picture'
      render 'new'
    end
  end

  def update
    @picture.update picture_params
    redirect_to picture_path(@picture)
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
    @picture = Picture.find(params[:id])
  end
end
