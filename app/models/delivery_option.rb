class DeliveryOption < ApplicationRecord
    validates :name, :cost, :delivery_time, presence: true
    has_many :carts
  end
  