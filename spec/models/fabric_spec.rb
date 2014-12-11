require 'rails_helper'

describe Fabric do
  it "should persist" do
    fabric = create(:fabric)
    expect(fabric).to be_persisted
  end

end
