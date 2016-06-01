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

  xit "returns name with case insensitive with spaces" do
    invoice = Invoice.create!(first_name: "Piper", last_name: "Shakes")

    get "/api/v1/invoices/find?fist_name=Piper"

    expect(response.status).to eq 200

    invoice = JSON.parse(response.body)

    expect(invoice["first_name"]).to eq "Piper"
    expect(invoice["last_name"]).to eq "Shakes"
  end

  xit "returns a random invoice" do
    invoice1 = Invoice.create!(first_name: "Piper", last_name: "Shakes")
    invoice2= Invoice.create!(first_name: "Scout", last_name: "Macbeth")
    invoice3= Invoice.create!(first_name: "Marty", last_name: "Peare")

    get "/api/v1/invoices/random"

    expect(response.status).to eq 200
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
