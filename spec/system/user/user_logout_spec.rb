require 'rails_helper'

describe 'User logs out of the application' do
  it 'successfully' do
    user = create(:user)

    login_as user
    visit root_path
    within '#navbar' do
      click_on 'Log out'
    end

    expect(page).to have_content 'Signed out successfully.'
    expect(page).not_to have_content user.email
    expect(page).to have_link 'Log in'
    expect(page).not_to have_link 'Log out'
  end
end
