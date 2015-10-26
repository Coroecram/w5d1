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

feature "displaying user goal index" do
  before :each do
    create_posts
  end

  scenario "home button redirects to user/:id/goals" do
    click_link "Home"
    expect(page).to have_content("Be friendlier")
  end

  scenario "user#show redirects to user user/goals#index" do
    visit user_url(1)
    expect(page).to have_content("Get a cat")
  end

  scenario "displays all user-created goals" do
    click_link "Home"
    expect(page).to have_content("Be friendlier")
    expect(page).to have_content("Get a cat")
  end

  scenario "display new link button if current user" do
    click_link "Home"
    expect(page).to have_content("New Goal")
  end

  scenario "does not display new link button if not user's page" do
    login_jimmy
    visit user_url(1)
    expect(page).not_to have_content("New Goal")
  end

  scenario "only display public goals of another user" do
    login_jimmy
    visit user_url(1)
    expect(page).to have_content("Be friendlier")
    expect(page).not_to have_content("Get a cat")
  end

  scenario "has edit button if logged in as goals owner" do
    click_link "Home"
    expect(page).to have_content("Edit")
  end

  scenario "has delete button if logged in as goals owner" do
    click_link "Home"
    expect(page).to have_content("Delete")
  end

end

feature "displaying single goal" do
  before :each do
    create_posts
  end
  scenario "cannot view individual show of another user's private goal" do
    login_jimmy
    visit goal_url(2)
    expect(page).not_to have_content("Get a cat")
  end

  scenario "can view individual show of another user's public goal" do
    login_jimmy
    visit goal_url(1)
    expect(page).to have_content("Be friendlier")
  end

  scenario "has edit button if logged in as goal owner" do
    visit goal_url(1)
    expect(page).to have_content "Edit"
  end

  scenario "has delete button if logged in as goal owner" do
    visit goal_url(1)
    expect(page).to have_content "Delete"
  end

  scenario "has no edit button if not logged in as owner" do
    login_jimmy
    visit goal_url(1)
    expect(page).not_to have_content "Edit"
  end

  scenario "has no delete button if not logged in as owner" do
    login_jimmy
    visit goal_url(1)
    expect(page).not_to have_content "Delete"
  end
end


feature "delete a goal" do
  before :each do
    create_posts
  end

  scenario "has delete button on show page if logged in as goal owner" do
    visit goal_url(1)
    expect(page).to have_content("Be friendlier")
    click_button "Delete"
    expect(page).to have_content("Get a cat")
    expect(page).not_to have_content("Be friendlier")
  end

  scenario "has delete button on goals index if logged in as goal owner" do
    login_jimmy
    create_jimmy_goal
    visit user_url(2)
    expect(page).to have_content("Go by James")
    click_button "Delete"
    expect(page).not_to have_content("Go by James")
  end
end

feature "edit a goal" do
  before :each do
    create_posts
  end

  scenario "has edit button on show page if logged in as goal owner" do
    visit goal_url(1)
    expect(page).to have_content("Be friendlier")
    click_link "Edit"
    fill_in "Name", with: "Get a dog"
    fill_in "Description", with: "a small one"
    choose "Public"
    click_button "Edit Goal"
    expect(page).to have_content("Get a dog")
  end

  scenario "has edit button on goals index if logged in as goal owner" do
    login_jimmy
    create_jimmy_goal
    visit user_url(2)
    expect(page).to have_content("Go by James")
    click_link "Edit"
    fill_in "Name", with: "Get a dog"
    fill_in "Description", with: "a small one"
    choose "Public"
    click_button "Edit Goal"
    expect(page).to have_content("Get a dog")
  end

  scenario "cannot edit or delete another user's goals" do
    login_jimmy
    visit edit_goal_url(1)
    expect(page).not_to have_content("Be friendlier")
  end

end
