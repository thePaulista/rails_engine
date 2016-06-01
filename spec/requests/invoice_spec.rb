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

    expect(response.status).to eq 200

    invoice = JSON.parse(response.body)

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

  xit "returns all invoice by the same params" do
    invoice1 = Invoice.create!(first_name: "Piper", last_name: "Shakes")
    invoice2 = Invoice.create!(first_name: "Scout", last_name: "Macbeth")
    invoice3 = Invoice.create!(first_name: "Piper", last_name: "Shakes")

    get "/api/v1/invoices/find_all?first_name=Piper"

    expect(response.status).to eq 200

    result = JSON.parse(response.body)

    expect(result.count).to eq 2
    expect(result.first["first_name"]).to eq "Piper"
    expect(result.last["first_name"]).to eq "Piper"
  end
end
