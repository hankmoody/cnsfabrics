class Fabric
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Timestamps

  field :code, type: String
  field :quantity, type: Integer
  field :width, type: Integer

  has_mongoid_attached_file :image, :styles => {
    thumbnail: "200x200>",
    big: "850x500>"
  }

  validates_presence_of :code
  validates_uniqueness_of :code
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
