class Product
  include Mongoid::Document

  attr_accessor :imageUrl

  field :productId, type: String
  field :title, type: String
  field :price, type: Float
  embeds_many :reviews
  embeds_many :aspects

end
