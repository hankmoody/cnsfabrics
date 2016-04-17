class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  has_and_belongs_to_many :fabrics
  validates_presence_of :name

  def self.get_tags (tag_string_list)
    tags = []
    tag_list = tag_string_list.downcase.split(',').map(&:strip)
    tag_list.each do |tag|
      tags << find_or_create_by(:name => tag)
    end
    tags
  end
end

