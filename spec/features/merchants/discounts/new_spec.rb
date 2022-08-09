require 'rails_helper'

RSpec.describe 'discounts new page' do
  it 'has a link to a form to create a new discount' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Revtrics", created_at: Time.now, updated_at: Time.now)

    discount_1 = Discount.create!(percent: 25, threshold: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percent: 15, threshold: 15, merchant_id: merchant_1.id)
    discount_3 = Discount.create!(percent: 20, threshold: 12, merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_1.id}/discounts/new"

    fill_in 'Percent Discount', with: -5
    fill_in 'Quantity Threshold', with: 27
    click_button 'Submit'
    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")
    expect(page).to have_content("Error: Percent must be greater than 0")

    fill_in 'Percent Discount', with: 130
    fill_in 'Quantity Threshold', with: 27
    click_button 'Submit'
    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")
    expect(page).to have_content("Error: Percent must be less than or equal to 100")

    fill_in 'Percent Discount', with: 30
    click_button 'Submit'
    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")
    expect(page).to have_content("Error: Threshold can't be blank")

    fill_in 'Quantity Threshold', with: 27
    click_button 'Submit'
    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")
    expect(page).to have_content("Error: Percent can't be blank")

    fill_in 'Percent Discount', with: 30
    fill_in 'Quantity Threshold', with: 27
    click_button 'Submit'

    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts")
    expect(page).to have_content("Percent Discount: 30%")
    expect(page).to have_content("Quantity Threshold: 27")
  end
end
