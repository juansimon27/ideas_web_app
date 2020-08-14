class UserMailer < ApplicationMailer

    def welcome_email(user)

        @user = user
        mail(to: @user.email, subject: 'Welcome - AppIdeas')

    end

    def password_reset(user)

        @user = user
        mail(to: @user.email, subject: 'Reset your password - AppIdeas') 

    end

end
