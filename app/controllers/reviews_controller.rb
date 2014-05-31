class ReviewsController < ApplicationController
	# params: product_id, keyword
	def index
		product = Product.where(productId: params[:product_id]).first
    @reviews = product.reviews.where(text: /.*#{params[:keyword]}*/i)
    respond_to do |format|
      format.json {
        render json: @reviews
      }
      format.js
    end
	end
end
