require 'rails_helper'

feature 'edit project', %q{
user can edit his created project
to correct smth
} do

  given!(:user) { create(:user) }
  given!(:project) { create(:project, user: user) }

  describe 'Authenticated user', js: true do

    scenario 'can see link Edit' do
      sign_in(user)
      visit projects_path
      page.find('.edit-project').trigger(:mouseover)
    end

    scenario 'tries to edit his project' do
      sign_in(user)
      visit projects_path
      page.find('.edit-project').trigger(:mouseover)
      page.find('.edit-project').click
      within(".form_in_place"){ fill_in("name", with: "edited project\n")}

      expect(page).to_not have_content project.name
      expect(page).to have_content 'edited project'
    end
  end
end