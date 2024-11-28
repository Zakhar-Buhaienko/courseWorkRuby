class AddForeignKeyToCarts < ActiveRecord::Migration[7.0]
  def change
    if foreign_key_exists?(:carts, :users)
      remove_foreign_key :carts, :users
    end

    add_foreign_key :carts, :users, on_delete: :cascade
  end
end
