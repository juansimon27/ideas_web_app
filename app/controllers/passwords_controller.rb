class PasswordsController < ApplicationController

    skip_before_action :authorized, only: [:new, :create, :edit, :update]

    def new
    end

    def create
        
        @user = User.find_by(email: params[:reset_password][:email])
    
        if @user

            @user.generate_password_reset_token!
            UserMailer.password_reset(@user).deliver_now

            redirect_to '/welcome', notice: 'Please check your email, we have sent a link to reset your password.'
            
        else

            flash.now[:alert] = "User email not found."
            render :new

        end

    end

    def edit

        @user = User.find_by(reset_password_token: params[:id])

        render file: 'public/404.html', status: :not_found unless @user

    end

    def update

        @user = User.find_by(reset_password_token: params[:id])

        if @user.update_attributes(password_params)

            @user.update_attribute(:reset_password_token, nil)
            session[:user_id] = @user.id

            redirect_to '/welcome', notice: 'Password successfully changed.'

        else

            flash.now[:alert] = "Unable to change your password, please try again."
            render :edit

        end
        
    end

    private

    def password_params

        params.require(:user).permit(:password, :password_confirmation)

    end

end
