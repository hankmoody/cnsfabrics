require 'rails_helper'

feature 'Admin' do

  before(:all) do
    user = create(:admin)
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
  end

  scenario "can update fabrics using valid excel sheet" do
    click_link 'Admin Panel'
    attach_file 'Excel file', 'spec/support/files/sheet_basic_valid.xlsx'
    click_button 'Submit'
    expect(page).to have_content 'cns 123 successfully added!'
    expect(page).to have_content 'cns 245 successfully added!'
  end

  scenario "can see errors for invalid records" do
    pending
  end
end
