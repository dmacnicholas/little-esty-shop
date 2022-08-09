require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :created_at }
    it { should validate_presence_of :updated_at }
    it { should define_enum_for(:status).with_values([:packaged, :pending, :shipped]) }
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe 'applied discounts' do
    it 'applies the greatest applied discount when threshold is met' do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
      merchant_2 = Merchant.create!(name: "Revtrics", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 30, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 40, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 50, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)
      customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
      invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 15, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 15, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      discount_1 = Discount.create!(percent: 20, threshold: 10, merchant_id: merchant_1.id)
      discount_2 = Discount.create!(percent: 30, threshold: 15, merchant_id: merchant_1.id)

      expect(invoice_item_1.discount_applied).to eq(discount_1)
      expect(invoice_item_2.discount_applied).to eq(discount_2)
      expect(invoice_item_3.discount_applied).to eq(nil)
    end
  end
end
