class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find params[:id]
    flash.now[:notice] = 'No pictures available' if @user.pictures.empty?
  end
end
