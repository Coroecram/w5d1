require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit "/users/new"
  end

  scenario "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  scenario "has a username and password input" do
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  scenario "has a Sign Up button" do
    click_button 'Sign Up'
  end
end

feature "signing up a user" do
  before :each do
    visit "/users/new"
  end

  scenario "will not accept empty username" do
    click_button 'Sign Up'
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Username can't be blank")
  end

  scenario "will not accept empty password" do
    fill_in 'Username', with: 'test_user'
    click_button 'Sign Up'
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Password is too short")
  end

  scenario "will not accept a password under 6 characters" do
    fill_in 'Username', with: 'test_user'
    fill_in 'Password', with: 'test'
    click_button 'Sign Up'
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Password is too short")
  end

  scenario "shows username on the homepage after signup" do
    fill_in 'Username', with: 'test_user'
    fill_in 'Password', with: 'test_password'
    click_button 'Sign Up'
    expect(page).to have_content("test_user")
  end
end

feature "logging in" do
  before :each do
    visit "session/new"
  end

  scenario "has a sign in page" do
    expect(page).to have_content("Sign In")
  end

  scenario "has a username and password input" do
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  scenario "has a Sign In button" do
    click_button 'Sign In'
  end
end

feature "signing in a user" do
  before :each do
    sign_up_lily
    visit "/session/new"
  end

  scenario "will not accept wrong username" do
    fill_in 'Password', with: 'Riopelle'
    click_button 'Sign In'
    expect(page).to have_content("Sign In")
    expect(page).to have_content "Invalid username/password"
  end

  scenario "will not accept a wrong password" do
    fill_in 'Username', with: 'Lily'
    fill_in 'Password', with: 'Riop'
    click_button 'Sign In'
    expect(page).to have_content("Sign In")
    expect(page).to have_content "Invalid username/password"
  end

  scenario "shows username on the homepage after sign in" do
    fill_in 'Username', with: 'Lily'
    fill_in 'Password', with: 'Riopelle'
    click_button 'Sign In'
    expect(page).to have_content("Lily")
  end
end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit "/users"
    expect(page).to have_content("Sign In")
  end

  scenario "shows logout when logged in" do
    sign_up_lily
    expect(page).to have_content("Log Out")
  end

  scenario "doesn't show user on the homepage after logout" do
    sign_up_lily
    click_button "Log Out"
    expect(page).not_to have_content("Lily")
  end

end
