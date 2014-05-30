class Modifier
  include Mongoid::Document
  field :word, type: String
  field :frequency, type: Integer
  embedded_in :aspect
end
