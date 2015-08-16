require 'rails_helper'

feature 'view projects on page', %q{
  onle me can see projects
} do

  scenario 'view projects' do
    user = create(:user)
    sign_in(user)
    project1 = create(:project, user: user)
    project2 = create(:project, user: user)
    task = create(:task, project: project1)

    visit projects_path

    expect(page).to have_content project1.name
    expect(page).to have_content project2.name

    within("#task-of-project-#{project1.id}") do
      expect(page).to have_content task.name
    end
  end
end