class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :creator?, :college_present?, :current_college


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def logged_in?
    !!current_user
  end

  def require_user
    redirect_to sign_in_path unless logged_in?
  end

  def creator?(user)
    logged_in? && current_user == user
  end

  def must_be_logged_out
    redirect_to college_user_my_books_path(current_user.college, current_user) if logged_in?
  end
  
  def current_college
    @college ||= College.where(id: params[:college_id]).first
    if @college.nil? && logged_in? && current_user.college
      @college ||= current_user.college
    end
    return @college
  end

  def college_present?
    !!current_college
  end

  def must_be_in_college
    redirect_to join_college_user_path(current_user) if current_user.college.nil?
  end
end
