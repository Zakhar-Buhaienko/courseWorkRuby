class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_product
  
    # POST /products/:product_id/reviews
    def create
      @review = @product.reviews.build(review_params.merge(user: current_user))
      if @review.save
        redirect_to @product, notice: 'Відгук додано.'
      else
        redirect_to @product, alert: 'Не вдалося додати відгук.'
      end
    end
  
    private
  
    def set_product
      @product = Product.find(params[:product_id])
    end
  
    def review_params
      params.require(:review).permit(:content, :rating)
    end
  end
  