require 'rails_helper'

RSpec.describe 'invoices show page' do
  it 'displays a list of all the invoices and their attributes' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
    invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
    invoice_2 = customer_1.invoices.create!(status: 2, created_at: Time.now, updated_at: Time.now)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

    # visit_merchant_invoice_path(merchant_1, invoice_1)
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_content(invoice_1.created_at.strftime("%-m/%d/%y"))
    expect(page).to have_content(invoice_1.full_name)
    expect(page).to_not have_content(invoice_2.id)
    expect(page).to_not have_content(invoice_2.status)

  end

  it 'shows all of my items on the invoice and their attributes' do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
    invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
    invoice_2 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
    invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

      expect(page).to have_content("Item Name: #{item_1.name}")
      expect(page).to have_content("Quantity Ordered: #{invoice_item_1.quantity}")
      expect(page).to have_content("Item Price: #{invoice_item_1.unit_price}")
      expect(page).to have_content("Invoice Item Status: #{invoice_item_1.status}")
      expect(page).to have_content("Item Name: #{item_2.name}")
      expect(page).to have_content("Quantity Ordered: #{invoice_item_2.quantity}")
      expect(page).to have_content("Item Price: #{invoice_item_2.unit_price}")
      expect(page).to have_content("Invoice Item Status: #{invoice_item_2.status}")
      expect(page).to have_content("Item Name: #{item_3.name}")
      expect(page).to have_content("Quantity Ordered: #{invoice_item_3.quantity}")
      expect(page).to have_content("Item Price: #{invoice_item_3.unit_price}")
      expect(page).to have_content("Invoice Item Status: #{invoice_item_3.status}")
      expect(page).to_not have_content("#{item_4.name}")
    end

    it 'shows the total revenue of all of the items on the invoice' do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
      invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_2 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_2.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_3.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

      visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

      expect(page).to have_content("Total Revenue: $12000")
    end

    it 'can update the invoice item status' do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
      invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_2 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

      visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       expect(invoice_item_1.status).to eq("packaged")
       select("pending", from: "status")
       click_button "Update Item Status"
       expect(current_path).to eq(merchant_invoice_path(merchant_1, invoice_1))
       expect(page).to have_content("pending")
     end

     it 'calculates that a bulk discount should not be applied to any items ' do
       merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
       item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 30, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 40, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 50, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
       invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
       invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       discount_1 = Discount.create!(percent: 20, threshold: 10, merchant_id: merchant_1.id)

       visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       expect(page).to have_content("Total Revenue: $600")
       expect(page).to have_content("Total Discounts: $0")
       expect(page).to have_content("Net Revenue: $600")
     end

     it 'calculates that a bulk discount should be applied to some items but not all items' do
       merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
       item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 30, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 40, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 50, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
       invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
       invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       discount_1 = Discount.create!(percent: 20, threshold: 10, merchant_id: merchant_1.id)

       visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       expect(page).to have_content("Total Revenue: $750")
       expect(page).to have_content("Total Discounts: $60")
       expect(page).to have_content("Net Revenue: $690")
     end

     it 'calculates that multiple bulk discounts should be applied to different items' do
       merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
       item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 30, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 40, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 50, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
       invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
       invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 15, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       discount_1 = Discount.create!(percent: 20, threshold: 10, merchant_id: merchant_1.id)
       discount_2 = Discount.create!(percent: 30, threshold: 15, merchant_id: merchant_1.id)

       visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       expect(page).to have_content("Total Revenue: $1150")
       expect(page).to have_content("Total Discounts: $240")
       expect(page).to have_content("Net Revenue: $910")
     end

     it 'calculates that multiple bulk discounts but uses the one with the higher percentage regardless of threshold' do
       merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
       item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 30, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 40, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 50, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
       customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
       invoice_1 = customer_1.invoices.create!(status: 1, created_at: Time.now, updated_at: Time.now)
       invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 15, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
       discount_1 = Discount.create!(percent: 20, threshold: 10, merchant_id: merchant_1.id)
       discount_2 = Discount.create!(percent: 15, threshold: 15, merchant_id: merchant_1.id)

       visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       expect(page).to have_content("Total Revenue: $1150")
       expect(page).to have_content("Total Discounts: $180")
       expect(page).to have_content("Net Revenue: $970")
     end

     it 'calculates that multiple bulk discounts for multiple merchants' do
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

       visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       expect(page).to have_content("Total Revenue: $1650")
       expect(page).to have_content("Total Discounts: $240")
       expect(page).to have_content("Net Revenue: $1410")
     end

     it 'has a link for each invoice item where a discount was applied' do
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

       visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       within "#invoice_item-#{invoice_item_1.id}" do
         expect(page).to have_link("Discount Applied")
       end

       within "#invoice_item-#{invoice_item_2.id}" do
         expect(page).to have_link("Discount Applied")
       end

       within "#invoice_item-#{invoice_item_3.id}" do
         expect(page).to_not have_link("Discount Applied")
       end
     end

     it 'directs the link to the discount show page' do
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

       visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

       within "#invoice_item-#{invoice_item_1.id}" do
         expect(page).to have_link("Discount Applied")
         click_link("Discount Applied")
         expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/#{discount_1.id}")
       end
     end

end
