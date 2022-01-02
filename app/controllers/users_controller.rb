class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @pagy, @orders = pagy(User.accessible_by(current_ability))
  end

  def show; end

  def create
    if @user.save
      flash[:success] = "Użytkownik №#{@user.id} został dodany"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "Użytkownik №#{@user.id} został zmieniony"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
  end

  protected

  def user_params
    params.require(:user).permit(:name, :surname, :email, :phone_number, :role, :password, :password_confirmation)
  end
end
