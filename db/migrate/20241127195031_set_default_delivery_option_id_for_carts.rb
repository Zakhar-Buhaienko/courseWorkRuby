class SetDefaultDeliveryOptionIdForCarts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :carts, :delivery_option_id, 1 # 1 — це ID за замовчуванням, змініть на відповідне значення
    change_column_null :carts, :delivery_option_id, false
    change_column_default :carts, :delivery_option_id, from: nil, to: DeliveryOption.first&.id
  end
end
