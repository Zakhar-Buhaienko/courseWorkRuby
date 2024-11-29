class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.text :address
      t.references :delivery_option, null: false, foreign_key: true
      t.string :payment_option
      t.decimal :total_price

      t.timestamps
    end
  end
end
