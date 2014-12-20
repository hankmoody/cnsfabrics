require 'rails_helper'

feature 'Admin Page' do
  scenario "is accessible to admins" do
    user = create(:admin)
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    expect(page).to have_content 'Admin Panel'
  end

  scenario "is not accessible to non-admins" do
    user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    expect(page).not_to have_content 'Admin Panel'
  end
end
