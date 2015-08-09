require 'rails_helper'

feature 'create task', %q{
  in order to set tasks I need to do
  as an authenticated user
  i want to able to create tasks
} do 

  given(:user) { create(:user) }
  given!(:project) { create(:project, user: user) }

  scenario 'authenticated user creates task' do
    sign_in(user)
    visit projects_path
    
    fill_in 'Name', with: 'Test task'
    click_on 'Add Task'

    expect(page).to have_content "Your task successfully created."
    expect(page).to have_content 'Test task'
  end

  scenario 'unautenticated user tries to create task' do
    visit projects_path

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end