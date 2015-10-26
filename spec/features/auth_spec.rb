require 'spec_helper'
require 'rails_helper'

feature "the signup process" do 

  before :each do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  it "has a username and password input" do
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  it "has a Sign Up button" do
    click_button 'Sign Up'
  end

    feature "signing up a user" do

      it "will not accept empty username" do
        click_button 'Sign Up'
        expect(page).to have_content("Sign Up")
        expect(page).to have_content("Username can't be blank")
      end

      it "will not accept empty password" do
        fill_in 'Username', with: 'test_user'
        click_button 'Sign Up'
        expect(page).to have_content("Sign Up")
        expect(page).to have_content("Password is too short")
      end

      it "will not accept a password under 6 characters" do
        fill_in 'Username', with: 'test_user'
        fill_in 'Password', with: 'test'
        click_button 'Sign Up'
        expect(page).to have_content("Sign Up")
        expect(page).to have_content("Password is too short")
      end

      it "shows username on the homepage after signup" do
        fill_in 'Username', with: 'test_user'
        fill_in 'Password', with: 'test_password'
        click_button 'Sign Up'
        expect(page).to have_content("test_user")
      end

    end

end
