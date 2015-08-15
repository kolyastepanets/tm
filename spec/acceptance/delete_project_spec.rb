require 'rails_helper'

feature 'delete project' do

  given(:user) { create(:user) }
  given!(:project) { create(:project, user: user) }

  scenario 'user can delete his project', js: true do
    sign_in(user)
    visit projects_path
    save_and_open_page
    find('.delete-project').click
    expect(page).to_not have_content project.name
  end
end