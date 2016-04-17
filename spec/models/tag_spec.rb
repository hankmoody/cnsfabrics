require 'rails_helper'

describe Tag do
  it "should require a name" do
    tag = build(:tag, :name => nil)
    expect(tag).not_to be_valid
  end
end
