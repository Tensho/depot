class OrderNotifier < ActionMailer::Base
  default from: "Tilda Shop Administration <depot@example.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def recieved(order)
    @order = order

    mail to: order.email, subject: "Order confirmation in Tilda Shop"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: "Order sent from Tilda Shop"
  end
end
