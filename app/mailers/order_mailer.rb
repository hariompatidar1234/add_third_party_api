class OrderMailer < ApplicationMailer
  def order_confirm(user)
    @user = user
    mail(to: @user.email, subject: 'Order confirm TO Uber_Eats !!')
  end
end
