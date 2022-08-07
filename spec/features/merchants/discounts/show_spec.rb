require 'rails_helper'

RSpec.describe 'discounts show page' do
  it 'displays the percent and threshold' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Revtrics", created_at: Time.now, updated_at: Time.now)

    discount_1 = Discount.create!(percent: 25, threshold: 10, merchant_id: merchant_1.id)
    discount_2 = Discount.create!(percent: 15, threshold: 15, merchant_id: merchant_1.id)
    discount_3 = Discount.create!(percent: 20, threshold: 12, merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_1.id}/discounts/#{discount_1.id}"

    expect(page).to have_content(discount_1.percent)
    expect(page).to have_content(discount_1.threshold)
    expect(page).to_not have_content(discount_2.percent)
    expect(page).to_not have_content(discount_2.threshold)
  end
end
