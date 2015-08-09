require 'rails_helper'

feature 'user signout', %q{
  user can sign out
}do

  given(:user) { create(:user) }

  scenario 'user sign out' do
    sign_in(user)
  
    click_on 'Log out'
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end