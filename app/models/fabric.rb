class Fabric
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Timestamps
  extend StorageSelector

  field :code, type: String
  field :quantity, type: Integer
  field :width, type: Integer

  before_create :drop_case

  paperclip_options = {
    :styles => {
      thumbnail: "200x200>",
      big: "850x500>"
    }
  }

  has_mongoid_attached_file :image, storage_selector.merge(paperclip_options)

  validates_presence_of :code
  validates_uniqueness_of :code
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  protected

  def drop_case
    self.code = self.code.downcase
  end

end
