class ApplicationController < ActionController::Base
  before_action :authorized

  # skip_before_action :authorized, only: [:new, :create] #this will lock down the app so the user can only use it if they're signed into their account
  helper_method :current_user

  def current_user
    #if our user is signed in then they should have a user id so we say that user's id should be whatever is currently held by session[user_id]
    User.find_by({id: session[:user_id]})
  end

  def logged_in?
    #!current_user returns false, so we use !!current_user to say this method returns true if it is true
    !!current_user
  end

  def authorized
    #the user is redirected if the logged_in? method does not return true
    redirect_to login_path unless logged_in?
  end

  def index
    #code
  end


end
