require 'rails_helper'

describe 'User visits the sign up page' do # rubocop:disable Metrics/BlockLength
  it 'from the navbar and views the form' do
    visit root_path
    within '#navbar' do
      click_on 'Log in'
    end
    click_on 'Sign up'

    expect(page).to have_field 'Email'
    expect(page).to have_field 'Password'
    expect(page).to have_field 'Password confirmation'
    expect(page).to have_button 'Sign up'
  end

  it 'and creates a new account' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(User.all.count).to eq 1
    within '#navbar' do
      expect(page).to have_button 'Log out'
      expect(page).not_to have_link 'Log in'
      expect(page).to have_content 'user@email.com'
    end
  end

  it "and can't create an account with bad parameters" do
    visit new_user_registration_path
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_on 'Sign up'

    expect(User.all).to be_empty
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Password'
    expect(page).to have_field 'Password confirmation'
    expect(page).to have_content 'Email can\'t be blank'
    expect(page).to have_content 'Password can\'t be blank'
  end
end
