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

      }
    end
  end

  def show
    @product = Product.where(productId: params[:id]).first
    @product.imageUrl = image_url_by_itemid(@product.productId)
  end

  private

  def image_url_by_itemid (itemId)
    req = Vacuum.new
    req.associate_tag = 'foobar'
    req.configure(
        aws_access_key_id: ENV['AWS_ID'],
        aws_secret_access_key: ENV['AWS_SECRET'],
        associate_tag: 'tag',
    )
    res = req.item_lookup(query: { 'IdType' => 'ASIN', 'ItemId' => itemId, 'ResponseGroup' => 'Images'})
    result = res.to_h
    result['ItemLookupResponse']['Items']['Item']['MediumImage']['URL']
  end

end
