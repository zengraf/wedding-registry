module SessionsHelper
  def log_in(user)
    # Create a session using Rails session management
    session[:user_id] = user.id
  end

  def current_user
    return nil unless session[:user_id]
    # Return already assigned user or assign the user at the first run
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
