class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_product = []
    @order.line_items.product.each do |p|
      product = Product.find(p[0].product_id)
      line = LineItem.where("order_id = #{@order.id}").where("product_id = #{product.id}")
      product.quantity = line[0].quantity
      product.price = line[0].total_price_cents / 100
      @order_product.push(product)
    end
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      @order_product = []
      order = Order.last
      order.line_items.product.each do |p|
        item = {}
        product = Product.find(p[0].product_id)
        line = LineItem.where("order_id = #{order.id}").where("product_id = #{product.id}")
        puts "line quantity is #{line[0].quantity}"
        item[:name] = product.name
        item[:amount] = line[0].quantity
        item[:subtotal] = line[0].total_price_cents / 100
        @order_product.push(item)
      end
      OrderMailer.email_order_receipt(order, @order_product).deliver_later
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_total, # in cents
      description: "K's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_total,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )
    cart.each do |product_id, details|
      if product = Product.find_by(id: product_id)
        quantity = details['quantity'].to_i
        order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
    end
    order.save!
    order
  end

  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0
    cart.each do |product_id, details|
      if p = Product.find_by(id: product_id)
        total += p.price_cents * details['quantity'].to_i
      end
    end
    total
  end

end
