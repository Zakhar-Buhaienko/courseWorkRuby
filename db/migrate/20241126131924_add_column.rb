class AddColumn < ActiveRecord::Migration[7.1]
  def change
    create_table :years do |t|
      add_column :users, :name, :string
      add_column :users, :phone, :string
    end
  end
end
