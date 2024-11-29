class CreateDeliveryOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_options do |t|
      t.string :name
      t.decimal :cost
      t.string :delivery_time

      t.timestamps
    end
  end
end
