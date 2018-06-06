class OrderMailer < ApplicationMailer
  def order_mail user, order, product
    @user = user
    @order = order
    @product = product
    mail to: user.email, subject: t("info_order")
  end
end
