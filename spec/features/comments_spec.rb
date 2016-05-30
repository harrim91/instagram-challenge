require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  before do
    visit root_path
    click_link 'Sign Up'
    fill_in :Email, with: 'test@example.com'
    fill_in :'User name', with: 'Michael'
    fill_in :Password, with: 'testtest'
    fill_in :'Password confirmation', with: 'testtest'
    click_button 'Sign up'
    visit '/pictures'
    click_link 'Add Picture'
    attach_file 'Image', "#{Rails.root}/spec/assets/images/smile.png"
    fill_in :Description, with: 'This is a picture'
    click_button 'Upload'
    visit picture_path(Picture.last)
  end

  context 'no comments have been added' do
    it 'has no comments section' do
      expect(page).not_to have_css 'div.comment'
    end
  end

  context 'adding a comment' do
    it 'adds the comment to the picture' do
      fill_in :'comment_content', with: 'This is a comment'
      click_button 'Add Comment'
      expect(current_path).to eq picture_path(Picture.last)
      within 'div.comment' do
        expect(page).to have_content User.last.user_name
        expect(page).to have_content 'This is a comment'
      end
    end
  end

  context 'deleting a comment' do
    it 'can be removed by the comment owner' do
      fill_in :'comment_content', with: 'This is a comment'
      click_button 'Add Comment'
      within 'div.comment' do
        click_link 'delete'
      end
      expect(current_path).to eq picture_path(Picture.last)
      expect(page).not_to have_css 'div.comment'
    end

    it 'can only be removed by the comment owner' do
      fill_in :'comment_content', with: 'This is a comment'
      click_button 'Add Comment'
      click_link 'Sign Out'
      visit root_path
      click_link 'Sign Up'
      fill_in :Email, with: 'test2@example.com'
      fill_in :'User name', with: 'Michael2'
      fill_in :Password, with: 'testtest'
      fill_in :'Password confirmation', with: 'testtest'
      click_button 'Sign up'
      visit picture_path(Picture.last)
      within 'div.comment' do
        expect(page).to have_content 'This is a comment'
        expect(page).not_to have_content 'delete'
      end
    end
  end
end
