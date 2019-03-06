class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create] #this is calling the authorized method from the Application controller. This is used so that the user doesn't have to be logged in, in order to signup for a new account, otherwise it makes no sense.

  #program comes here when it gets a get request for the path /login and renders the new.erb
  def new
    render 'new'
  end

  #when the user submits their login info the program gets a post request to /login which then comes here
  def create
    #see if the user's name exists in the database and save it to an instance variable
    # byebug
    @user = User.find_by(name: params[:name])
      # byebug
    #if the user name does exist AND their authentification checks out using their submitted password, which is saved in the params, then we set session at a key of user_id to this user's object id (this is what allows their session to continually persist no matter which page they navigate to) then redirect them to their show page
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    #else we direct user back to the login page with the invalid message
    else
      flash[:message] = "Invalid username or password"
      redirect_to login_path
    end
  end

  def delete
    session.delete(:user_id)
    flash[:message] = "You have logged out"
    redirect_to login_path
  end
end
