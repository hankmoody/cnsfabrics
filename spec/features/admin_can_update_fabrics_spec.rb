require 'rails_helper'

feature 'Admin' do

  let!(:user) { create(:admin) }

  scenario "can update fabrics using valid excel sheet" do
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    click_link 'Admin Panel'
    attach_file 'Excel file', 'spec/support/files/sheet_basic_valid.xlsx'
    click_button 'Submit'
    fabric = Fabric.find_by code: 'test 123'
    expect(fabric).to_not be_nil
    fabric = Fabric.find_by code: 'test 245'
    expect(fabric).to_not be_nil
  end

end
