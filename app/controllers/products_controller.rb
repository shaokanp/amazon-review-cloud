require 'vacuum'

class ProductsController < ApplicationController

  # with keywords params
  def index

    respond_to do |format|
      format.html
      format.json {
        products = Product.where(title: /.*#{params[:keyword]}*/i)
        render json: products
      }
      format.js{
        @products = Product.without(:aspects).where(title: /.*#{params[:keyword]}*/i).entries
        #@products.each do |product|
        #  product.imageUrl = image_url_by_itemid(product.productId)
        #end
      }
    end
  end

  def show
    @product = Product.where(productId: params[:id]).first
    @product.imageUrl = image_url_by_itemid(@product.productId)
    respond_to do |format|
      format.js
    end
  end

  def image_url
    productId = Product.where(productId: params[:product_id]).first.productId
    url = image_url_by_itemid(productId)
    respond_to do |format|
      format.json{
        render json: url
      }
    end
  end

  private

  def image_url_by_itemid (itemId)
    begin

      Amazon::Ecs.options = {
        :associate_tag => 'haha',
        :AWS_access_key_id => AWS['AWS_ID'],       
        :AWS_secret_key => AWS['AWS_SECRET']
      }

      res = Amazon::Ecs.item_lookup(itemId,{:ResponseGroup => 'Images'})
      res.first_item.get_hash('MediumImage')['URL']
    rescue
      nil
    end
  end
end
