require 'rails_helper'

describe "Item business logic" do
  it "returns the date with the most sales for the given item using the invoice date" do
    item = Item.create(name: "coxinha")
    merchant = Merchant.create(name: "padaria")

    date = "2016-06-03T00:00:00.000Z"

    invoice1 = Invoice.create(merchant_id: merchant.id, created_at: Date.today)
    invoice2 = Invoice.create(merchant_id: merchant.id, created_at: date)
    invoice3 = Invoice.create(merchant_id: merchant.id, created_at: date)
    invoice4 = Invoice.create(merchant_id: merchant.id, created_at: Date.today + 1)
    invoice_item1 = InvoiceItem.create(item_id: item.id, invoice_id: invoice1.id, quantity: 2)
    invoice_item2 = InvoiceItem.create(item_id: item.id, invoice_id: invoice2.id, quantity: 2)
    invoice_item3 = InvoiceItem.create(item_id: item.id, invoice_id: invoice3.id, quantity: 2)
    invoice_item4 = InvoiceItem.create(item_id: item.id, invoice_id: invoice4.id, quantity: 2)
    Transaction.create(invoice_id: invoice1.id, result: "success")
    Transaction.create(invoice_id: invoice2.id, result: "success")
    Transaction.create(invoice_id: invoice3.id, result: "success")
    Transaction.create(invoice_id: invoice4.id, result: "success")

    get "/api/v1/items/#{item.id}/best_day"

    best_day = JSON.parse(response.body, :quirks_mode => true)

    expect(response.status).to eq 200
    expect(best_day).to eq date
  end
end

