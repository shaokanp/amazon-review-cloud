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
        @products = Product.without(:aspects).where(title: /.*#{params[:keyword]}*/i)
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

  private

  def image_url_by_itemid (itemId)
    begin
      req = Vacuum.new
      req.associate_tag = 'foobar'
      req.configure(
          aws_access_key_id: AWS['AWS_ID'],
          aws_secret_access_key: AWS['AWS_SECRET'],
          associate_tag: 'tag',
      )
      res = req.item_lookup(query: { 'IdType' => 'ASIN', 'ItemId' => itemId, 'ResponseGroup' => 'Images'})
      result = res.to_h
      result['ItemLookupResponse']['Items']['Item']['MediumImage']['URL']
    rescue
      nil
    end
  end
end
