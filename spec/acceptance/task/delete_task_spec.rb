require 'rails_helper'

feature 'delete task' do

  given(:user) { create(:user) }
  given!(:project) { create(:project, user: user) }
  given!(:task) { create(:task, project: project) }

  scenario 'user can delete his task', js: true do
    sign_in(user)
    visit projects_path
    page.find('.delete-task').trigger(:mouseover)
    page.find('.delete-task').click
    expect(page).to_not have_content task.name
  end
end