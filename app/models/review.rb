class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
