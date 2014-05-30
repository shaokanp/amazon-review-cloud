class Product
  include Mongoid::Document
  field :productId, type: String
  field :title, type: String
  field :price, type: Float
  field :imageUrl, type: String
  embeds_many :reviews
  embeds_many :aspects
end
