class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new

    @user = User.new

  end

  def create

    @user = User.create(user_params)

    if @user.save

      UserMailer.welcome_email(@user).deliver_now

      session[:user_id] = @user.id

      redirect_to '/welcome'

    else

      render 'new'

    end

  end

  private

  def user_params

    params.require(:user).permit(:username, :email, :password, :password_confirmation)

  end
  
end
