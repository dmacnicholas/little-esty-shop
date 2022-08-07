require 'rails_helper'

RSpec.describe 'discounts index page' do
  it 'displays a list of all the discounts and their attributes' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Revtrics", created_at: Time.now, updated_at: Time.now)

    discount_1 = Discount.create!(percent: 25, threshold: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percent: 15, threshold: 5, merchant_id: merchant_1.id)
    discount_3 = Discount.create!(percent: 20, threshold: 12, merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_1.id}/discounts"

    within("#discount-#{discount_1.id}") do
      expect(page).to have_content(discount_1.percent)
      expect(page).to have_content(discount_1.threshold)
      expect(page).to have_link("View Discount #{discount_1.id}")
    end

    within("#discount-#{discount_2.id}") do
      expect(page).to have_content(discount_2.percent)
      expect(page).to have_content(discount_2.threshold)
      expect(page).to have_link("View Discount #{discount_2.id}")
    end

    expect(page).to_not have_content(discount_3.percent)
    expect(page).to_not have_content(discount_3.threshold)
    expect(page).to_not have_link("View Discount #{discount_3.id}")
    click_link("View Discount #{discount_1.id}")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/#{discount_1.id}")
  end

  it 'has a link toa form to create a new discount' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Revtrics", created_at: Time.now, updated_at: Time.now)

    discount_1 = Discount.create!(percent: 25, threshold: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percent: 15, threshold: 5, merchant_id: merchant_1.id)
    discount_3 = Discount.create!(percent: 20, threshold: 12, merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_1.id}/discounts"

    expect(page).to_not have_content("Percent Discount: 30%")
    expect(page).to_not have_content("Quantity Threshold: 27")
    expect(page).to have_content("Create New Discount")
    click_link("Create New Discount")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")

    fill_in 'Percent Discount', with: '130'
    fill_in 'Quantity Threshold', with: '27'
    click_button 'Submit'
    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")

    fill_in 'Percent Discount', with: '30'
    fill_in 'Quantity Threshold', with: '27'
    click_button 'Submit'

    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts")
    expect(page).to have_content("Percent Discount: 30%")
    expect(page).to have_content("Quantity Threshold: 27")
  end

end
