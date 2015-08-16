require 'rails_helper'

feature 'edit task', %q{
user can edit his created task
to correct smth
} do

  given!(:user) { create(:user) }
  given!(:project) { create(:project, user: user) }
  given!(:task) { create(:task, project: project) }

  describe 'Authenticated user', js: true do

    scenario 'can see link Edit' do
      sign_in(user)
      visit projects_path
      page.find('.edit-task').trigger(:mouseover)
    end

    scenario 'tries to edit his project' do
      sign_in(user)
      visit projects_path
      page.find('.edit-task').trigger(:mouseover)
      page.find('.edit-task').click
      within(".form_in_place"){ fill_in("name", with: "edited task\n")}

      expect(page).to_not have_content task.name
      expect(page).to have_content 'edited task'
    end
  end
end