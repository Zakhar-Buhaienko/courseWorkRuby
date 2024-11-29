class AddDefaultToCartItemsDeliveryOptionId < ActiveRecord::Migration[7.1]
  def change
    change_column_default :cart_items, :delivery_option_id, 1
  end
end
