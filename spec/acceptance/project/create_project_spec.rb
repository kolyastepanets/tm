require 'rails_helper'

feature 'create project', %q{
  in order to make new todo list
  as an authenticated user
  i want to able to create project
} do

  given(:user) { create(:user) }

  scenario 'authenticated user creates project', js: true do
    sign_in(user)

    visit projects_path
    click_on 'Add TODO List'
    fill_in 'Name', with: 'Test project'
    click_on 'Create'

    expect(page).to have_content 'Test project'
  end

  scenario 'unautenticated user tries to create question' do
    visit projects_path

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end