class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    puts "Printing params #{user_params}"
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to "/signup"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end
