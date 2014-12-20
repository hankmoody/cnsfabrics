require 'rails_helper'

feature 'User' do
  scenario "can sign in and out with valid credentials" do
    user = create(:user)
    visit root_path
    expect(page).not_to have_content('Sign out')
    click_link 'Sign in'
    expect(current_path).to eq(new_user_session_path)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    expect(page).to have_content('Signed in successfully')
    expect(current_path).to eq(root_path)
    click_link 'Sign out'
    expect(page).to have_content('Signed out successfully')
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Sign in')
  end

  scenario "cannot sign in with wrong credentials" do
    visit new_user_session_path
    fill_in "Email", :with => 'fake@email.com'
    fill_in "Password", :with => 'fakepassword'
    click_button "Sign in"
    expect(page).to have_content('Invalid email or password')
  end
end
