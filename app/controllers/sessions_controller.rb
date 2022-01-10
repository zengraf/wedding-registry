class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
    redirect_to agenda_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to agenda_path
    else
      # Display incorrect credentials error on login screen
      flash.now[:danger] = t('messages.incorrect_credentials')
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
