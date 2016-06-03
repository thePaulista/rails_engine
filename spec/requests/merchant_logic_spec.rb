require "rails_helper"

describe "For one merchant" do
  it "returns revenue for a merchant across all transactions" do
    merchant1, merchant2 = create_list(:merchant, 2)
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = customer1.invoices.create(merchant_id: merchant1.id, status: "shipped")
    invoice2 = customer2.invoices.create(merchant_id: merchant2.id, status: "shipped")
    Transaction.create(invoice_id: invoice1.id, credit_card_number: "1234", result: "success")
    Transaction.create(invoice_id: invoice1.id, credit_card_number: "1234", result: "success")
    item1 = create(:item)
    InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 20.00)

    get "/api/v1/merchants/#{merchant1.id}/revenue"

    revenue = JSON.parse(response.body, :quirks_mode => true)

    expect(response.status).to eq 200
  # expect(revenue).to eq({"revenue"=>"20.00"})
  end

  it "returns the customer who has conducted the most total number of successful transactions" do
    merchant1, merchant2 = create_list(:merchant, 2)
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = customer1.invoices.create(merchant_id: merchant1.id, status: "shipped")
    invoice2 = customer2.invoices.create(merchant_id: merchant2.id, status: "shipped")
    Transaction.create(invoice_id: invoice1.id, credit_card_number: "1234", result: "success")
    Transaction.create(invoice_id: invoice1.id, credit_card_number: "1234", result: "success")
    item1 = create(:item)
    InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 10.00)

    get "/api/v1/merchants/#{merchant1.id}/favorite_customer"

    favorite = JSON.parse(response.body, :quirks_mode => true)

    expect(response.status).to eq 200
    expect(favorite["id"]).to eq customer1.id
    expect(favorite["first_name"]).to eq customer1.first_name
    expect(favorite["last_name"]).to eq customer1.last_name
  end

  it "returns a collection of customers which have pending (unpaid) invoices" do
    merchant1, merchant2 = create_list(:merchant, 2)
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = customer1.invoices.create(merchant_id: merchant1.id, status: "on hold")
    invoice2 = customer2.invoices.create(merchant_id: merchant2.id, status: "shipped")
    Transaction.create(invoice_id: invoice1.id, credit_card_number: "1234", result: "failed")
    Transaction.create(invoice_id: invoice1.id, credit_card_number: "1234", result: "failed")
    Transaction.create(invoice_id: invoice2.id, credit_card_number: "234", result: "success")
    item1 = create(:item)
    InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 10.00)

    get "/api/v1/merchants/#{merchant1.id}/customers_with_pending_invoices"

    pending_invoice = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(pending_invoice[0]["id"].to_i).to eq customer1.id
    expect(pending_invoice[0]["first_name"]).to eq customer1.first_name
    expect(pending_invoice[0]["last_name"]).to eq customer1.last_name
  end
end
