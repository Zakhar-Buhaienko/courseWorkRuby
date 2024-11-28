class HomeController < ApplicationController
    def index
      @featured_products = Product.where(featured: true).limit(5)
      @new_products = Product.order(created_at: :desc).limit(5)
      @popular_products = Product.order(sold_count: :desc).limit(5)
    end
  end
  