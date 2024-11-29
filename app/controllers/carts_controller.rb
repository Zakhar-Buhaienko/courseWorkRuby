class CartsController < ApplicationController
  before_action :authenticate_user! # Переконуємося, що користувач залогінений
  before_action :set_cart

  def create
    @cart = Cart.new(user_id: current_user.id, delivery_option_id: params[:delivery_option_id] || 1)
    if @cart.save
      redirect_to @cart, notice: 'Cart created successfully.'
    else
      render :new, alert: 'Failed to create cart.'
    end
  end

  # GET /cart
  def show
    @cart_items = @cart.cart_items.includes(:product)
    @delivery_options = DeliveryOption.all # Передаємо всі варіанти доставки
  end

  # POST /cart/add_item
  def add_item
    product = Product.find(params[:product_id]) # Ensure the product exists
    quantity_to_add = params[:quantity].to_i
    quantity_to_add = 1 if quantity_to_add <= 0 # Default to 1 if invalid
  
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity ||= 0
    cart_item.quantity += quantity_to_add
    cart_item.delivery_option_id ||= DeliveryOption.first.id # Assign default delivery option
  
    if cart_item.save
      redirect_to cart_path, notice: 'Товар додано до корзини.'
    else
      redirect_to cart_path, alert: 'Не вдалося додати товар до корзини.'
    end
  end
  
  

  # DELETE /cart/remove_item/:id
  def remove_item
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: 'Товар видалено з корзини.'
  end

  def update_cart
    item = CartItem.find(params[:item_id])
    quantity_change = params[:quantity].to_i
    new_quantity = [item.quantity + quantity_change, 1].max
    item.update(quantity: new_quantity)
    redirect_to cart_path, notice: 'Кількість оновлено'
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

  def set_default_quantity
    self.quantity ||= 0
  end
end
