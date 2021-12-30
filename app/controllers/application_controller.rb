class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  before_action :require_login

  def require_login
    return true if logged_in?

    flash[:danger] = 'Żeby uzyskać dostęp do tej strony, należy zalogować się'
    redirect_to login_url
  end
end
