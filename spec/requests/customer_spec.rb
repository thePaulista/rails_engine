require 'rails_helper'

describe "GET /api/v1/customers/:id" do
  xit "finds one customer" do
    customer1, customer2 = create_list(:customer, 2)

    get "/api/v1/customers/#{customer1.id}", render: :json

    expect(response.status).to eq 200
    require "pry"; binding.pry
    customer = JSON.parse(response.body)

    expect
  end
end
