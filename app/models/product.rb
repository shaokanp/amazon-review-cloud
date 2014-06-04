class Product
  include Mongoid::Document

  attr_accessor :imageUrl
  attr_accessor :description
  attr_accessor :brand

  field :productId, type: String
  field :title, type: String
  field :price, type: Float
  field :reviewCount, type: Integer, default: 0
  embeds_many :reviews
  embeds_many :aspects

end
