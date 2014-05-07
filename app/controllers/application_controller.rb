class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :login?, :myid, :myname

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    def login?
      !!session[:user_id]
    end
    def myid
      session[:user_id]
    end
    def myname
      session[:name]
    end
    def login user
      session[:user_id] = user.id
      session[:name]    = user.name
    end
    def logout
      session[:user_id] = nil
      session[:name]    = nil
    end
end
