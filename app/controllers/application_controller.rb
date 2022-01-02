class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :require_login
  around_action :switch_locale

  protected

  def require_login
    return true if logged_in?

    flash[:danger] = 'Żeby uzyskać dostęp do tej strony, należy zalogować się'
    redirect_to login_url
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def current_user
    return nil unless session[:user_id]
    # Return already assigned user or assign the user at the first run
    @current_user ||= User.find(session[:user_id])
  end
  helper_method :current_user

  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

  def log_in(user)
    # Create a session using Rails session management
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
