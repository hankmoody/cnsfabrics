require 'rails_helper'

describe Fabric do
  it "should require a code" do
    fabric = build(:fabric, :code => nil)
    expect(fabric).not_to be_valid
  end

  it "should require an image" do
    fabric = build(:fabric, :image => nil)
    expect(fabric).not_to be_valid
  end

  it "should successfully attach an image" do
    fabric = create(:fabric)

    expect(fabric.image_file_name).not_to be_nil
    expect(fabric.image_file_size).not_to be_nil
    expect(fabric.image_content_type).not_to be_nil
    expect(fabric.image_updated_at).not_to be_nil
  end

  it "should auto downcase code before saving" do
    fabric = create(:fabric, :code => "CNS 123")
    expect(fabric.code).to eq "cns 123"
  end

  it "should return search results in reverse chron for updated date" do
    fabric1 = create(:fabric, :code => "CNS 123", :tag_list => "checks, voile")
    create(:fabric, :code => "CNS 124", :tag_list => "chambray, voile")
    fabric3 = create(:fabric, :code => "CNS 125", :tag_list => "checks, stripes")

    fabric1.update_attributes(:width => 27)
    fabric_list = Fabric.search('checks')
    expect(fabric_list).to be == [fabric1, fabric3]

    fabric3.update_attributes(:width => 27)
    fabric_list = Fabric.search('checks')
    expect(fabric_list).to be == [fabric3, fabric1]
  end

  it "should perform case insensitive search " do
    fabric1 = create(:fabric, :code => "CNS 123", :tag_list => "checks, voile")
    create(:fabric, :code => "CNS 124", :tag_list => "chambray, voile")
    fabric3 = create(:fabric, :code => "CNS 125", :tag_list => "checks, stripes")

    fabric_list = Fabric.search('ChECks')
    expect(fabric_list).to be == [fabric3, fabric1]
  end

end
