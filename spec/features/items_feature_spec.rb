require 'rails_helper'

describe "Item" do
  before do
    sign_up
  end
  context "no items have been added" do
    scenario "should display a prompt to add an item" do
      visit '/items'
      expect(page).to have_content 'No items yet'
      expect(page).to have_link 'Add an item'
    end
  end

  context 'items have been added' do
    before do
      add_an_item
    end

    scenario 'display items' do
      visit '/items'
      expect(page).to have_content 'Pokemon onesie'
      expect(page).not_to have_content 'No items yet'
    end

  end

  context 'adding an item' do
    scenario 'prompts user to fill out a form, then displays the new item' do
      visit '/items'
      click_link 'Add an item'
      fill_in('Description', with: 'Best beast for best Halloween')
      fill_in('Size', with: 'M')
      fill_in('Color', with: 'Red')
      fill_in('Category', with: 'Costume')
      click_button('Create Item')
      expect(page).to have_content 'Best beast for best Halloween'
      expect(page).to have_content 'Item was successfully created'
      expect(current_path).to eq "/items"
    end

    scenario 'adds an item with an image' do
      upload_bayon_photo
      expect(page).to have_content 'Best beast for best Halloween'
      expect(page).to have_content 'Item was successfully created'
      expect(page).to have_css("img[src*='ban.jpg']")

    end
  end

end
