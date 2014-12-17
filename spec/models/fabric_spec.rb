require 'rails_helper'

describe Fabric do
  it "should require a code" do
    fabric = build(:fabric, :code => nil)
    expect(fabric).not_to be_valid
  end

  it "should successfully attach an image" do
    fabric = create(:fabric, :image => File.new(Rails.root + 'spec/support/images/test_image.png'))

    expect(fabric.image_file_name).not_to be_nil
    expect(fabric.image_file_size).not_to be_nil
    expect(fabric.image_content_type).not_to be_nil
    expect(fabric.image_updated_at).not_to be_nil
  end

end
