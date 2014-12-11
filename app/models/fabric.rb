class Fabric
  include Mongoid::Document

  field :code, type: String
  field :quantity, type: Integer
  field :width, type: Integer

  validates_presence_of :code
  validates_uniqueness_of :code
end
