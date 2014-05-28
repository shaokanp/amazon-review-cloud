class Review
  include Mongoid::Document
  field :userId, type: String
  field :profileName, type: String
  field :helpfulnessTotal, type: Integer
  field :helpfulness, type: Integer
  field :score, type: Integer
  field :time, type: Time
  field :summary, type: String
  field :text, type: String
  embedded_in :product
end
