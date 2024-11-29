class AddDefaultToDeliveryOptionInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :carts, :delivery_option_id, from: nil, to: 1
  end
end
