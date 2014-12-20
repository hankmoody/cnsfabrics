require 'rails_helper'

describe User do
  it "should not create a user with empty password" do
    user = build(:user, :password => "")
    expect(user).not_to be_valid
  end

  it "should not create a user with invalid email" do
    user = build(:user, :email => "blah")
    expect(user).not_to be_valid
  end

  it "should create a user with no admin privileges by default" do
    user = create(:user)
    expect(user.admin).to be false
  end
end
