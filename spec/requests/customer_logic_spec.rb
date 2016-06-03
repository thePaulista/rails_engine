require 'rails_helper'

describe "Customer business logic" do
  it "returns a merchant where the customer has conducted the most successful transactions" do
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)
    customer1, customer2, customer3 = create_list(:customer, 3)
    invoice1 = customer1.invoices.create!(merchant_id: merchant1.id, status: "pending")
    invoice2 = customer2.invoices.create!(merchant_id: merchant2.id, status: "pending")
    invoice3 = customer2.invoices.create!(merchant_id: merchant3.id, status: "pending")
    transaction1 = invoice1.transactions.create(result: "success")
    transaction2 = invoice1.transactions.create(result: "success")
    transaction3 = invoice2.transactions.create(result: "error")

    get "/api/v1/customers/#{customer1.id}/favorite_merchant"

    favorite_merchant = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(favorite_merchant["name"]).to eq merchant1.name
  end
end
