class Aspect
  include Mongoid::Document
  field :word, type: String
  field :frequency, type: Integer
  embedded_in :product
  embeds_many :modifiers
end
