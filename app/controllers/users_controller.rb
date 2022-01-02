class UsersController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def create
    @user.create
  end

  def edit; end

  def update
    @user.update(user_params)
  end

  def destroy
    @user.destroy
  end

  protected

  def user_params
    params.require(:user).permit(:name, :surname, :email, :phone_number, :role, :password, :password_confirmation)
  end
end
