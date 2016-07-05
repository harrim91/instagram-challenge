require 'rails_helper'

RSpec.feature "Pictures", type: :feature do
  context 'logged in' do
    before do
      visit root_path
      click_link 'Sign Up'
      fill_in :Email, with: 'test@example.com'
      fill_in :'User name', with: 'Michael'
      fill_in :Password, with: 'testtest'
      fill_in :'Password confirmation', with: 'testtest'
      click_button 'Sign up'
    end

    context 'no pictures have been added' do
      it 'gives an error message' do
        visit '/pictures'
        within 'div.flash-messages' do
          expect(page).to have_content 'No pictures available'
        end
        expect(page).not_to have_css 'div.pictures-wrapper'
      end
    end

    context 'adding a picture' do
      it 'saves the picture' do
        visit '/pictures'
        click_link 'Add Picture'
        expect(current_path).to eq '/pictures/new'
        attach_file 'Image', "#{Rails.root}/spec/assets/images/smile.png"
        fill_in :Description, with: 'This is a picture'
        click_button 'Upload'
        expect(current_path).to eq '/pictures'
        within 'div.pictures-wrapper' do
          expect(page.find('img')['src']).to have_content 'smile.png'
          expect(page).to have_content 'This is a pictu...'
        end
      end

      it 'raises an error if no image is submitted' do
        visit '/pictures/new'
        fill_in :Description, with: 'This is a nice picture'
        click_button 'Upload'
        within 'div.flash-messages' do
          expect(page).to have_content 'There were errors uploading the picture'
        end
        within 'form' do
          expect(page).to have_css 'input#picture_image'
          expect(page).to have_css 'input#picture_description'
        end
      end
    end

    context 'a picture has been added' do
      before do
        visit '/pictures/new'
        attach_file 'Image', "#{Rails.root}/spec/assets/images/smile.png"
        fill_in :Description, with: 'This is a picture'
        click_button 'Upload'
      end

      context 'viewing a picture' do
        it 'shows the picture' do
          within('div.pictures-wrapper') { click_link page.find('img')['alt="This is a picture"'] }
          expect(current_path).to eq picture_path(Picture.last)
          within 'div.pictures-wrapper' do
            expect(page.find('img')['src']).to have_content 'smile.png'
            expect(page).to have_content 'This is a picture'
          end
        end
      end

      context 'editing a picture' do
        it 'can update the description' do
          picture = Picture.last
          visit picture_path(picture)
          click_link 'Edit'
          expect(current_path).to eq edit_picture_path(picture)
          fill_in :Description, with: 'New description'
          click_button 'Update Description'
          expect(current_path).to eq picture_path(picture)
          expect(page).to have_content 'New description'
        end
      end

      context 'deleting a picture' do
        it 'removes the picture' do
          picture = Picture.last
          visit picture_path(picture)
          click_link 'Edit'
          click_link 'Delete'
          expect(current_path).to eq pictures_path
          within 'div.flash-messages' do
            expect(page).to have_content 'No pictures available'
          end
          expect(page).not_to have_css 'div.pictures-wrapper'
        end
      end

      it 'only allows the poster to edit or delete' do
        click_link 'Sign Out'
        click_link 'Sign Up'
        fill_in :Email, with: 'test2@example.com'
        fill_in :'User name', with: 'Michael2'
        fill_in :Password, with: 'testtest'
        fill_in :'Password confirmation', with: 'testtest'
        click_button 'Sign up'
        picture = Picture.last
        visit picture_path(picture)
        expect(page).not_to have_content 'Edit'
        visit edit_picture_path(picture)
        expect(current_path).to eq pictures_path
        expect(page).to have_content 'Only the picture owner can edit'
      end
    end
  end

  context 'logged out' do
    scenario 'renders the login page' do
      visit '/pictures'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
    scenario 'cannot add a picture' do
      visit '/pictures'
      expect(page).not_to have_content 'Add Picture'
    end
  end
end
