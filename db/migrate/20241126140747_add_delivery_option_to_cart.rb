class AddDeliveryOptionToCart < ActiveRecord::Migration[7.1]
  def change
    add_reference :carts, :delivery_option, null: false, foreign_key: true
  end
end
