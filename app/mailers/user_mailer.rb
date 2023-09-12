class UserMailer < ApplicationMailer
    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: "Welcome TO Uber_Eats !!")
      end
end
