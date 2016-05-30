require 'rails_helper'

RSpec.feature "Likes", type: :feature do
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
    visit picture_path(Picture.last)
  end

  scenario 'liking a picture' do
    within '.like-count' do
      expect(page).to have_content '0'
    end
    within '.like-button' do
      expect(page).to have_css '.glyphicon-star-empty'
      click_link 'like-button'
    end
    expect(current_path).to eq picture_path(Picture.last)
    within '.like-button' do
      expect(page).to have_css '.glyphicon-star'
    end
    within '.like-count' do
      expect(page).to have_content '1'
    end
  end

  scenario 'unliking a picture' do
    click_link 'like-button'
    click_link 'unlike-button'
    expect(current_path).to eq picture_path(Picture.last)
    within '.like-button' do
      expect(page).to have_css '.glyphicon-star-empty'
    end
    within '.like-count' do
      expect(page).to have_content '0'
    end
  end
end
