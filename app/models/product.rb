class Product < ApplicationRecord
    has_many :cart_items
    has_many :reviews, dependent: :destroy
    has_one_attached :image
  end
  