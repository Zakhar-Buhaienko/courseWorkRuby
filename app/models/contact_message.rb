class ContactMessage < ApplicationRecord
    validates :name, :email, :message, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Некоректний email" }
  end
  