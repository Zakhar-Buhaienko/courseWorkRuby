class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_option, optional: true
  has_many :cart_items, dependent: :destroy
end
