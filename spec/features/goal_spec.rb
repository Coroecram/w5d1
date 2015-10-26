require 'spec_helper'
require 'rails_helper'

feature "the create new goal process" do
  before :each do
    sign_up_lily
    visit '/goals/new'
  end

  scenario "has a new goal page" do
    expect(page).to have_content("New Goal")
  end

  scenario "has a name and description input, and private radio buttons" do
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Private")
    expect(page).to have_content("Public")
  end

  scenario "has a functional private/public option"do
    choose "Public"
    choose "Private"
  end

  scenario "has a Create Goal button" do
    click_button "Create Goal"
  end

  scenario "will not accept empty name" do
    click_button "Create Goal"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "will not accept empty description" do
    fill_in "Name", with:("Git r done")
    click_button "Create Goal"
    expect(page).to have_content("Description can't be blank")
  end

  scenario "redirects to created goal's show page" do
    fill_in "Name", with:("Git r done")
    fill_in "Description", with:("Do it")
    click_button "Create Goal"
    expect(page).to have_content("Git r done")
    expect(page).to have_content("Do it")
  end

end
