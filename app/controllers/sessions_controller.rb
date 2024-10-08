class SessionsController < ApplicationController
  def new
    session[:user_id] = nil
    @user = User.new
  end

  def create
    @user = User.find_by(username: user_params[:username])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = "User not found. Please check username/password"
      redirect_to "/signin"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/signin"
  end

  private

  def user_params
    params.require(:user).permit(:password, :username)
  end
end
