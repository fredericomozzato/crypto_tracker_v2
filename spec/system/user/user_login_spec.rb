require 'rails_helper'

describe 'User visits the sign in page' do # rubocop:disable Metrics/BlockLength
  it 'from the navbar and views the form' do
    visit root_path
    within '#navbar' do
      click_on 'Log in'
    end

    expect(page).to have_field 'Email'
    expect(page).to have_field 'Password'
    expect(page).to have_button 'Log in'
  end

  it 'and logs in' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within 'form' do
      click_on 'Log in'
    end

    expect(page).to have_content 'Signed in successfully'
    within('#navbar') do
      expect(page).to have_content user.email
      expect(page).to have_button 'Log out'
      expect(page).not_to have_link 'Log in'
    end
  end

  it 'and can\'t log in with invalid params' do
    create(:user)

    visit new_user_session_path
    fill_in 'Email', with: 'wrong_user@email.com'
    fill_in 'Password', with: 'badpassword'
    within 'form' do
      click_on 'Log in'
    end

    expect(page).to have_content 'Invalid Email or password'
  end
end
