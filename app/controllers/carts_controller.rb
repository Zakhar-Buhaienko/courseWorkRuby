class CartsController < ApplicationController
  before_action :authenticate_user! # Переконуємося, що користувач залогінений
  before_action :set_cart

  # GET /cart
  def show
    @cart_items = @cart.cart_items.includes(:product)
    @delivery_options = DeliveryOption.all # Передаємо всі варіанти доставки
  end

  # POST /cart/add_item
  def add_item
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)

    cart_item.quantity += params[:quantity].to_i
    if cart_item.save
      redirect_to cart_path, notice: 'Товар додано до корзини.'
    else
      redirect_to products_path, alert: 'Не вдалося додати товар до корзини.'
    end
  end

  # DELETE /cart/remove_item/:id
  def remove_item
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: 'Товар видалено з корзини.'
  end

  # PATCH /cart/select_delivery
  def select_delivery
    delivery_option = DeliveryOption.find(params[:delivery_option_id])
    if @cart.update(delivery_option: delivery_option)
      redirect_to cart_path, notice: 'Спосіб доставки обрано.'
    else
      redirect_to cart_path, alert: 'Не вдалося обрати спосіб доставки.'
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart(delivery_option: DeliveryOption.first)
  end
end
