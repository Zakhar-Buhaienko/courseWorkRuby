class CreateCartItems < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!
  
  def change
    create_table :cart_items do |t|
      t.integer :cart_id, null: false
      t.integer :product_id, null: false
      t.integer :delivery_option_id, null: false
      t.integer :quantity

      t.timestamps
    end

    add_foreign_key :cart_items, :carts
    add_foreign_key :cart_items, :products
    add_foreign_key :cart_items, :delivery_options
  end
end
