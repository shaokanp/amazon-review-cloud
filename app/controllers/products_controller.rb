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
        aws_access_key_id: 'AKIAIQWGW3XYCCPTXN6A',
        aws_secret_access_key: '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',
        associate_tag: 'tag',
    )
    res = req.item_lookup(query: { 'IdType' => 'ASIN', 'ItemId' => itemId, 'ResponseGroup' => 'Images'})
    result = res.to_h
    result['ItemLookupResponse']['Items']['Item']['MediumImage']['URL']
  end

end
