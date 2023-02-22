module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def not_logged_in?
    current_user.nil?
  end

  def user_required
    return if logged_in?

    flash[:alert] = 'You must be logged in.'
    redirect_to login_path
  end
end
