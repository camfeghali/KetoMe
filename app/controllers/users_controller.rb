class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :custom_view, only: :show

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def destroy # DELETE request /users/:id
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'Your account has been deleted'
    redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

  def custom_view
    @user = User.find(params[:id])
    if current_user.id != @user.id
      flash[:notice] = "You are not logged into this account"
      redirect_to current_user
    end
  end
end

#   skip_before_action :authorized, only: [:new, :create]
#
#   def index
#     @users = User.all
#   end
#
#   def show
#     @user = User.find(params[:id])
#   end
#
#   #Rails comes here and runs this method when it sees that the path is /users/new
#   def new
#     @user = User.new
#     render "new"
#   end
#
#   #Program comes here after user hits submit button, which sends post request for /users/new
#   def create
#     @user = User.create(user_params)
#     session[:user_id] = @user.id
#     redirect_to user_path(@user)
#   end
#
#   def edit
#     @user = User.find(params[:id])
#   end
#
#   def update
#     user = User.find(params[:id])
#     user.update(user_params)
#     redirect_to user_path(user)
#   end
#
#   def destroy
#     user = User.find(params[:id])
#     user.delete
#
#     redirect_to new_user_path
#   end
#
#   private
#
#   def user_params
#     params.require(:user).permit(:name, :password)
#   end
# end
