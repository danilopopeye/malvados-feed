class Strip
  include Mongoid::Document
  include Mongoid::Timestamps::Updated

  field :number, type: Integer
  field :image, type: String
  field :header, type: String
  field :previous, type: Integer

  validates_presence_of :number, :image, :previous
  validates_uniqueness_of :number, :previous
end
