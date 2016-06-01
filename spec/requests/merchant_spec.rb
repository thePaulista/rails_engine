require 'rails_helper'

#describe Api::V1::MerchantsController do
#  before(:each) do
#    merchant1, merchant2 = create_list(:merchant, 2)
#    #Merchant.create(name: "Another merchant")
#    #@merchant = Merchant.create(name: "Jones and Company")
#  end
#
#  describe "Get index" do
#    it "shows all merchants" do
#      get "/api/v1/merchants",  format: :json
#      merchants = JSON.parse(response.body, symbolize_names: true)
#
#      expect(response).to have_http_status(:success)
#      expect(merchants.first[:name]).to eq ""
#      expect(merchants.last[:name]).to eq "Jones and Company"
#    end
#  end
#end
RSpec.describe "Merchant API" do
  context "GET api/v1/merchant" do
    it "returns all the merchants" do
      merchant1 = Merchant.create(name: 'Merchant1')
      merchant2 = Merchant.create(name: 'Merchant2')

      get "/api/v1/merchants", {}, { "Accept" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      merchant_names = body.map { |m| m["name"] }

      expect(merchant_names).to match_array(["Merchant1",
                                             "Merchant2"])
    end
  end
  end
