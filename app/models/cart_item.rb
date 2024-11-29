class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :delivery_option

  before_validation :set_default_delivery_option

  private

  def set_default_delivery_option
    self.delivery_option_id ||= DeliveryOption.first.id # Or set a specific default ID
  end

  def update_cart
    item = CartItem.find(params[:item_id])
    quantity_change = params[:quantity_change].to_i
    new_quantity = [item.quantity + quantity_change, 1].max
    item.update(quantity: new_quantity)
    redirect_to cart_path, notice: 'Кількість оновлено'
  end
  
end
