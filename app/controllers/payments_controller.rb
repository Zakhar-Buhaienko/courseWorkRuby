class PaymentsController < ApplicationController
  def create
      Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
  
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: @cart.cart_items.map do |item|
          {
            price_data: {
              currency: 'usd',
              product_data: {
                name: item.product.name,
              },
              unit_amount: (item.product.price * 100).to_i, # У центрах
            },
            quantity: item.quantity,
          }
        end,
        mode: 'payment',
        success_url: success_url,
        cancel_url: cancel_url
      )
  
      redirect_to session.url, allow_other_host: true
    end
  end
  