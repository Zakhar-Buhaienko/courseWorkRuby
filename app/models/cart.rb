class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_option, optional: true
  has_many :cart_items, dependent: :destroy

  before_validation :ensure_delivery_option

  private

  def ensure_delivery_option
    self.delivery_option_id ||= DeliveryOption.first.id
  end
end
