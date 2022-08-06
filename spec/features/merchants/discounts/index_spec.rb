require 'rails_helper'

RSpec.describe 'discounts index page' do
  it 'displays a list of all the discounts and their attributes' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Revtrics", created_at: Time.now, updated_at: Time.now)

    discount_1 = Discount.create!(percent: 25, threshold: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percent: 15, threshold: 5, merchant_id: merchant_1.id)
    discount_3 = Discount.create!(percent: 20, threshold: 10, merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_1.id}/discounts"

    within("#discount-#{@disocunt_1.id}") do
      expect(page).to have_content(@discount_1.percent)
      expect(page).to have_content(@discount_1.threshold)
    end

    within("#discount-#{@disocunt_2.id}") do
      expect(page).to have_content(@discount_2.percent)
      expect(page).to have_content(@discount_2.threshold)
    end

    expect(page).to_not have_content(@discount_3.percent)
    expect(page).to_not have_content(@discount_3.threshold)
  end
end
