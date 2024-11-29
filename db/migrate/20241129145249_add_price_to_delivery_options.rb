class AddPriceToDeliveryOptions < ActiveRecord::Migration[7.1]
  def change
    add_column :delivery_options, :price, :decimal
  end
end
