require 'rails_helper'

describe "Merchant" do
  context "GET api/v1/merchant" do
    it "returns all the merchants" do
      merchant1 = Merchant.create(name: 'Venice')
      merchant2 = Merchant.create(name: 'Verona')

      get "/api/v1/merchants"

      expect(response.status).to eq 200

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(2)
    end
  end

  it "returns one merchant" do
    merchant = Merchant.create!(name: "Venice")

    get "/api/v1/merchants/#{merchant.id}"

    merchant = JSON.parse(response.body)
    expect(response.status).to eq 200
    expect(merchant["name"]).to eq "Venice"
  end

  it "returns merchant by name" do
    merchant = Merchant.create!(name: "Verona")

    get "/api/v1/merchants/find?name=Verona"

    expect(response.status).to eq 200

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq "Verona"
  end

  it "returns name with case insensitive with spaces" do
    merchant = Merchant.create!(name: "Piper scout and Marty")

    get "/api/v1/merchants/find?name=Piper%20scout%20and%20Marty"

    expect(response.status).to eq 200

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq "Piper scout and Marty"
  end

  it "returns a random merchant" do
    merchant1 = Merchant.create!(name: "Venice")
    merchant2 = Merchant.create!(name: "Piper")
    merchant3 = Merchant.create!(name: "Verona")
    merchants = [merchant1["id"], merchant2["id"], merchant3["id"]]

    get "/api/v1/merchants/random"

    random_merchant = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(merchants).to include(random_merchant[0]["id"])
  end

  it "returns all merchant by the same params" do
    merchant1 = Merchant.create!(name: "Venice")
    merchant2 = Merchant.create!(name: "Piper scout and Marty")
    merchant3 = Merchant.create!(name: "Venice")

    get "/api/v1/merchants/find_all?name=Venice"

    expect(response.status).to eq 200

    result = JSON.parse(response.body)

    expect(result.count).to eq 2
    expect(result.first["name"]).to eq "Venice"
    expect(result.last["name"]).to eq "Venice"
  end
end
