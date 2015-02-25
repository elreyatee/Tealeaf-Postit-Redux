class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception # when using a pure HTML form, you have to disable this but
                                        # we want to keep the athenticity token

  helper_method :current_user, :logged_in? #makes these methods avail in all controller actions and viewer templates

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # if instance var exits, does not hit the database
  end

  def logged_in?
    !!current_user # turns any object into boolean value
  end

  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end
  end
end
