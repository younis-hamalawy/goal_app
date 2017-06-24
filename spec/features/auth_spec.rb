require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before(:each) { visit(new_user_url) }

  scenario "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      fill_in('Username', with: 'Ryan')
      fill_in('Password', with: 'password')
      click_button('Sign Up')
      visit(users_url)
      expect(page).to have_content("Ryan")
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login"

end

feature "logging out" do

  scenario "begins with a logged out state"

  scenario "doesn't show username on the homepage after logout"

end
