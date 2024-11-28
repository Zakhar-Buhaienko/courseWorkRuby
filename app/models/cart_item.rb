class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  # Валідація кількості
  validates :quantity, numericality: { greater_than: 0 }
end
