class OrderMailerPreview < ActionMailer::Preview
  def email_order_receipt
    OrderMailer.email_order_receipt(order)
  end
end