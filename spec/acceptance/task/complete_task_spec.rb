# require 'rails_helper'

# feature 'complete task', %q{
#   in order to see which tasks are done
#   as an authenticated user
#   i want to mark task as completed
# } do

#   given(:user) { create(:user) }
#   given!(:project) { create(:project, user: user) }
#   given!(:task) { create_list(:task, 4, project: project) }

#   describe 'authenticated user creates task', js: true do
#     before do
#       sign_in(user)
#       visit projects_path
#     end

#     scenario 'make first task completed' do
#       within("#task-#{task[1].id}") do
#         checkbox = find("input[type='checkbox'][id='status']").set(true)
#         # pry
#         # save_and_open_page
#         expect(checkbox).to have_checked_field('status')
#       end
#     end
#   end

#   scenario 'unautenticated user tries to create task' do
#     visit projects_path

#     expect(page).to have_content "You need to sign in or sign up before continuing."
#   end
# end