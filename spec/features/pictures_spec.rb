require 'rails_helper'

RSpec.feature "Pictures", type: :feature do
  context 'logged in' do
    before do
      visit root_path
      click_link 'Sign Up'
      fill_in :Email, with: 'test@example.com'
      fill_in :Password, with: 'testtest'
      fill_in :'Password confirmation', with: 'testtest'
      click_button 'Sign up'
    end

    context 'no pictures have been added' do
      it 'gives an error message' do
        visit '/pictures'
        within 'p.notice' do
          expect(page).to have_content 'No pictures available'
        end
        expect(page).not_to have_css 'section.pictures'
      end
    end

    context 'adding a picture' do
      'it saves the picture' do
        visit '/pictures'
        click_button 'Add Picture'
        expect(current_path).to eq 'pictures/new'
        #select a picture
        fill_in :Description, with: 'This is a nice picture'
        click_button 'Upload'
        expect(current_path).to eq 'pictures'
        within 'section.pictures' do
          # expect(page).to have_picture '[picture]'
          expect(page).to have_content 'This is a nice picture'
        end
      end
    end
  end

  context 'logged out' do
    scenario 'redirects to login page' do
      visit '/pictures'
      expect(current_path).to eq new_user_session_path
    end
  end
end
