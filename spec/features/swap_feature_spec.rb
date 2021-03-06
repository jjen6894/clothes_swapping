require 'rails_helper'

describe "Swap" do

  let(:mony) { create(:user) }
  let(:jack) { create(:user, email: "testthisthing@test.com", id: '101') }

  before do
    login_as(jack, :scope => :user)
    jack_item = create(:item, user_id: jack.id, color: 'blue', description: "Squirtle Onesie", id: "201")
    sign_out
    login_as(mony, :scope => :user)
    mony_item = create(:item, user_id: mony.id, id: '200')
    requester =  jack_item.requesters.create(item_id: jack_item.id, user_id: mony.id)
    sign_out
    login_as(jack, :scope => :user)
    visit "/users/#{jack.id}"
    click_link("Requests received")
    click_link("#{mony.email}'s wardrobe")
  end
  
  scenario "build a selector" do
    expect{click_link("Request back")}.to change{Selector.count}.by(1)
  end

  scenario "user should see both items" do
    click_link("Request back")
    visit "/users/#{jack.id}"
    click_link("Swaps")
    expect(page).to have_css("img[src*='pokemon_onesie.jpg']")
  end

  scenario "user has made a swap, there item should no longer display on the homepage" do
    click_link("Request back")
    visit "/"
    expect(page).not_to have_css("img[src*='pokemon_onesie.jpg']")
  end

  scenario "user has made a swap, there item should no longer display in their wardrobe" do
    login_as(jack, :scope => :user)
    visit "/users/#{jack.id}"
    click_link("Requests received")
    click_link("#{mony.email}'s wardrobe")
    click_link("Request back")
    visit "/users/#{jack.id}/profile/wardrobe"
    expect(page).not_to have_css("img[src*='pokemon_onesie.jpg']")
  end

end
