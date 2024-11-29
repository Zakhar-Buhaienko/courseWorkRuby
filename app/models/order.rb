class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_option, optional: true

  has_many :order_items, dependent: :destroy

  validates :name, :email, :phone, :address, :payment_option, presence: true
end
