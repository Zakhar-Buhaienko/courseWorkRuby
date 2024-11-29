class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = Order.new
    @cart = current_user.cart || current_user.create_cart(delivery_option: DeliveryOption.first)
  end

  def create
    @order = current_user.orders.new(order_params)
    @cart = current_user.cart || current_user.create_cart(delivery_option: DeliveryOption.first)
    @order.total_price = @cart.cart_items.sum { |item| item.product.price * item.quantity }

    if @order.save
      @cart.cart_items.each do |cart_item|
        @order.order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end
      @cart.cart_items.destroy_all
      redirect_to order_path(@order), notice: 'Замовлення створено успішно.'
    else
      render :new, alert: 'Не вдалося створити замовлення.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :delivery_option_id, :payment_option)
  end
end
