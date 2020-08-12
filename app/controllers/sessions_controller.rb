class SessionsController < ApplicationController
  
  skip_before_action :authorized, only: [:new, :create, :welcome]
  
  def new
  end

  def create

    @user = User.find_by(username: params[:login_user][:username])

    if @user && @user.authenticate(params[:login_user][:password])

      session[:user_id] = @user.id
      redirect_to '/welcome'

    else
      
      redirect_to '/login'
      flash.now[:alert] = 'User not found!'

    end
  end


  def login
  end


  def welcome
  end


  def page_requires_login
  end


  def destroy

    session.destroy
    redirect_to '/welcome'

  end
end
