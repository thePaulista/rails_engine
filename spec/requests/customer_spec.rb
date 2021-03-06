require 'rails_helper'

describe "Customer" do
  context "GET api/v1/customer" do
    it "returns all the customer" do
      customer1 = Customer.create(first_name: 'Venice', last_name: "Shakes")
      customer2 = Customer.create(first_name: 'Verona', last_name: "Peare")

      get "/api/v1/customers"

      expect(response.status).to eq 200

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(2)
    end
  end

  it "returns one customer" do
    customer = Customer.create!(first_name: "Venice", last_name: "Shakes")

    get "/api/v1/customers/#{customer.id}"

    customer = JSON.parse(response.body)
    expect(response.status).to eq 200
    expect(customer["first_name"]).to eq "Venice"
    expect(customer["last_name"]).to eq "Shakes"
  end

  it "returns customer by name" do
    customer = Customer.create!(first_name: "Venice", last_name: "Shakes")

    get "/api/v1/customers/find?first_name=Venice"

    expect(response.status).to eq 200

    customer = JSON.parse(response.body)

    expect(customer["first_name"]).to eq "Venice"
  end

  it "returns name with case insensitive with spaces" do
    customer = Customer.create!(first_name: "Piper", last_name: "Shakes")

    get "/api/v1/customers/find?fist_name=Piper"

    expect(response.status).to eq 200

    customer = JSON.parse(response.body)

    expect(customer["first_name"]).to eq "Piper"
    expect(customer["last_name"]).to eq "Shakes"
  end

  it "returns a random customer" do
    customer1 = Customer.create!(first_name: "Piper", last_name: "Shakes")
    customer2 = Customer.create!(first_name: "Scout", last_name: "Macbeth")
    customer3 = Customer.create!(first_name: "Marty", last_name: "Peare")
    customers = [customer1["id"], customer2["id"], customer3["id"]]

    get "/api/v1/customers/random"
    random_customer = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(customers).to include(random_customer[0]["id"])
  end

  it "returns all customer by the same params" do
    customer1 = Customer.create!(first_name: "Piper", last_name: "Shakes")
    customer2 = Customer.create!(first_name: "Scout", last_name: "Macbeth")
    customer3 = Customer.create!(first_name: "Piper", last_name: "Shakes")

    get "/api/v1/customers/find_all?first_name=Piper"

    expect(response.status).to eq 200

    result = JSON.parse(response.body)

    expect(result.count).to eq 2
    expect(result.first["first_name"]).to eq "Piper"
    expect(result.last["first_name"]).to eq "Piper"
  end

  it "returns a collection of associated invoices" do
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = customer1.invoices.create!(merchant_id: merchant1.id, status: "pending")
    invoice2 = customer2.invoices.create!(merchant_id: merchant2.id, status: "pending")
    invoice3 = customer2.invoices.create!(merchant_id: merchant3.id, status: "pending")


    get "/api/v1/customers/#{customer2.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(invoices.count).to eq 2
    expect(invoices[0]["customer_id"]).to eq customer2.id
    expect(invoices[1]["customer_id"]).to eq customer2.id
   end
end
