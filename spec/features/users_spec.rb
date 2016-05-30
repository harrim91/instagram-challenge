require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context 'viewing a profile' do
    before do
      visit root_path
      click_link 'Sign Up'
      fill_in :Email, with: 'test@example.com'
      fill_in :'User name', with: 'Michael'
      fill_in :Password, with: 'testtest'
      fill_in :'Password confirmation', with: 'testtest'
      click_button 'Sign up'
      visit '/pictures/new'
      attach_file 'Image', "#{Rails.root}/spec/assets/images/smile.png"
      fill_in :Description, with: 'This is a picture'
      click_button 'Upload'
      click_link 'Sign Out'
      click_link 'Sign Up'
      fill_in :Email, with: 'test2@example.com'
      fill_in :'User name', with: 'Michael2'
      fill_in :Password, with: 'testtest'
      fill_in :'Password confirmation', with: 'testtest'
      click_button 'Sign up'
    end

    scenario 'pictures are shown on the users profile' do
      user = User.first
      within('div.pictures-wrapper') { click_link page.find('img')['alt="This is a picture"'] }
      within('div.picture-head') { click_link user.user_name }
      expect(current_path).to eq user_path(user)
      within 'div.pictures-wrapper' do
        expect(page.find('img')['src']).to have_content 'smile.png'
        expect(page).to have_content 'This is a picture'
      end
    end

    scenario 'only owned pictures are shown on the profile' do
      user = User.last
      within('nav') { click_link user.user_name }
      expect(current_path).to eq user_path(user)
      expect(page).not_to have_css 'div.pictures-wrapper'
      expect(page).to have_content 'No pictures available'
    end
  end
end
