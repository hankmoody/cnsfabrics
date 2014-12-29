class Fabric
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Timestamps
  extend StorageSelector

  field :code, type: String
  field :quantity, type: Integer
  field :width, type: Integer

  before_validation :drop_case

  paperclip_options = {
    :styles => {
      thumbnail: "",
      big: "",
    },
    :convert_options => {
      :thumbnail => "-gravity Center -crop 600x500+0+0 +repage -resize '240>'",
      :big => "-gravity Center -crop 600x500+0+0 +repage -resize '500>'"
    }
  }

  has_mongoid_attached_file :image, storage_selector.merge(paperclip_options)

  validates_presence_of :code
  validates_uniqueness_of :code
  validates :image, :dimensions => { :width => 600, :height => 500 }
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  protected

  def drop_case
    self.code = self.code.downcase
  end

  def self.search (search)
    search_conditions = Regexp.new "#{search}"
    Fabric.any_of({
      :code => search_conditions
    })
  end

end
