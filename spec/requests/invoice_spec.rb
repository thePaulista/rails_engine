require 'rails_helper'

describe "Invoice" do
  context "GET api/v1/invoice" do
    it "returns all the invoice" do
      customer1, customer2 = create_list(:customer, 2)
      invoice1 = Invoice.create(customer_id: customer1.id)
      invoice2 = Invoice.create(customer_id: customer2.id)

      get "/api/v1/invoices"

      expect(response.status).to eq 200

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)
    end
  end

  it "returns one invoice" do
    customer = create(:customer)
    invoice = Invoice.create!(customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}"

    invoice = JSON.parse(response.body)
    expect(response.status).to eq 200
    expect(invoice["customer_id"]).to eq  customer.id
   end

  it "returns invoice by a singular params" do
    customer = create(:customer)
    invoice = Invoice.create!(id: 2, customer_id: customer.id, status: "pending")

    get "/api/v1/invoices/find?status=pending"

    expect(response.status).to eq 200

    invoice = JSON.parse(response.body)

    expect(invoice["status"]).to eq "pending"
  end

  it "returns name with case insensitive with spaces" do
    customer = create(:customer)
    invoice = Invoice.create!(id: 1, customer_id: customer.id, status: "pending")

    get "/api/v1/invoices/find?status=pending"

    invoice = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(invoice["id"]).to eq 1
    expect(invoice["status"]).to eq "pending"
  end

  it "returns a random invoice" do
    customer1, customer2, customer3 = create_list(:customer, 3)
    invoice1 = Invoice.create!(id: 1, customer_id: customer1.id)
    invoice2= Invoice.create!(id: 2, customer_id: customer2.id)
    invoice3= Invoice.create!(id: 3, customer_id: customer2.id)
    invoices = [invoice1["id"], invoice2["id"], invoice3["id"]]

    get "/api/v1/invoices/random"

    random_invoice = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(random_invoice.count).to eq 1
    expect(invoices).to include(random_invoice[0]["id"])
  end

  it "returns all invoice by the same params" do
    invoice1 = create(:invoice, status: "pending")
    invoice2 = create(:invoice, status: "completed")
    invoice3 = create(:invoice, status: "pending")

    get "/api/v1/invoices/find_all?status=pending"

    result = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(result.count).to eq 2
    expect(result.first["status"]).to eq "pending"
    expect(result.last["status"]).to eq "pending"
  end

  it "returns a collection of associated transactions" do
   customer1, customer2 = create_list(:customer, 2)
   merchant1, merchant2 = create_list(:merchant, 2)
   invoice1 = merchant1.invoices.create!(customer_id: customer1.id)
   invoice2 = merchant2.invoices.create!(customer_id: customer2.id)
   invoice1.transactions.create!(credit_card_number: "1234", credit_card_expiration_date: "11/20", result: "success!!!!!!!")
   invoice1.transactions.create!(credit_card_number: "2234", credit_card_expiration_date: "11/20", result: "success!!!!!!!")
   invoice2.transactions.create!(credit_card_number: "4321", credit_card_expiration_date: "11/20", result: "shucks!!!!!!!")

   get "/api/v1/invoices/#{invoice1.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(transactions.count).to eq 2
    expect(transactions[0]["invoice_id"]).to eq invoice1.id
    expect(transactions[1]["invoice_id"]).to eq invoice1.id
  end

  it "returns a collection of invoice items" do
    #customer1, customer2 = create_list(:customer, 2)
    #merchant1, merchant2 = create_list(:merchant, 2)
    item1, item2 = create_list(:item, 2)
    invoice1, invoice2 = create_list(:invoice, 2)
    invoice1.invoice_items.create!(item_id: item1.id)
    invoice2.invoice_items.create(item_id: item2.id, unit_price: 10.00)
    invoice2.invoice_items.create(item_id: item1.id, unit_price: 10.00)

    get "/api/v1/invoices/#{invoice2.id}/invoice_items"

    invoice_item = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(invoice_item.count).to eq 2
    expect(invoice_item[0]["invoice_id"]).to eq invoice2.id
    expect(invoice_item[1]["invoice_id"]).to eq invoice2.id
  end

  it "returns a collection of items" do
   invoice1, invoice2 = create_list(:invoice, 2)

   invoice1.items.create!(name: "Coxinha", description: "So yummy", unit_price: "5.00")
   invoice2.items.create!(name: "Esfiha", description: "Second best stuff", unit_price: "5.00")
   invoice2.items.create!(name: "Pastel Especial", description: "Delicious only when freshly fried", unit_price: "6.00")

   get "/api/v1/invoices/#{invoice2.id}/items"

   items = JSON.parse(response.body)

   expect(response.status).to eq 200
   expect(items.count).to eq 2
   expect(items[0]["name"]).to eq "Esfiha"
   expect(items[1]["name"]).to eq "Pastel Especial"
  end

  it "returns an associated customer" do
    merchant1, merchant2 = create_list(:merchant, 2)
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = customer1.invoices.create!(merchant_id: merchant1.id, status: "shipped" )
    invoice2 = customer2.invoices.create!(merchant_id: merchant2.id, status: "shipped")

    get "/api/v1/invoices/#{invoice1.id}/customer"

    customer = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(customer["first_name"]).to eq customer1.first_name
    expect(customer["last_name"]).to eq customer1.last_name
   end

  it "returns an associated merchant" do
    merchant1, merchant2 = create_list(:merchant, 2)
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = customer1.invoices.create!(merchant_id: merchant1.id, status: "pending")
    invoice2 = customer2.invoices.create!(merchant_id: merchant2.id, status: "pending")

    get "/api/v1/invoices/#{invoice2.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(merchant["name"]).to eq merchant2.name
   end
end
