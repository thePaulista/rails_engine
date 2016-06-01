require 'rails_helper'

RSpec.describe "Customer API" do
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

    get "/api/v1/customers/random"

    expect(response.status).to eq 200
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
end
