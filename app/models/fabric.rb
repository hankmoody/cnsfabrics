class Fabric
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Timestamps
  extend StorageSelector

  field :code, type: String
  field :quantity, type: Integer
  field :width, type: Integer
  attr_accessor :is_cropped

  before_validation :drop_case

  paperclip_options = {
    :styles =>
      lambda do |attachment|
        if attachment.instance.is_cropped
          {
            :thumbnail => {
              :convert_options => "-resize '240>'"
            },
            :big => {
              :convert_options => "-resize '500>'"
            }
          }
        else
          {
            :thumbnail => {
              :convert_options => "-gravity Center -crop 600x500+0+0 +repage -resize '240>'"
            },
            :big => {
              :convert_options => "-gravity Center -crop 600x500+0+0 +repage -resize '500>'"
            }
          }
        end
      end
  }

  has_mongoid_attached_file :image, storage_selector.merge(paperclip_options)
  has_mongoid_attached_file :original_image, storage_selector

  validates_presence_of :code
  validates_uniqueness_of :code
  validates :image, :dimensions => { :width => 600, :height => 500 }
  validates :original_image, :dimensions => { :width => 600, :height => 500 }
  validates_attachment_presence :image
  validates_attachment_presence :original_image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates_attachment_content_type :original_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  protected

  def drop_case
    self.code = self.code.downcase unless self.code.nil?
  end

  def self.search (search)
    search_conditions = Regexp.new "#{search}"
    Fabric.any_of({
      :code => search_conditions
    })
  end

end
