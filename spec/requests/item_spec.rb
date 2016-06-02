require 'rails_helper'

describe "Items" do
  context "GET api/v1/item" do
    it "can return all items" do
      item1, item2 = create_list(:item, 2)

      get "/api/v1/items"

      expect(response.status).to eq 200

      items = JSON.parse(response.body)

      expect(items.count).to eq(2)
  end

    it "can return one item" do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      item = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(item["name"]).to eq item["name"]
    end

    it "can return item by name" do
      item = create(:item, name: "Piper")

      get "/api/v1/items/find?name=Piper"

      expect(response.status).to eq 200

      item = JSON.parse(response.body)

      expect(item["name"]).to eq "Piper"
    end

    it "returns name with case insensitive with spaces" do
      item = create(:item, name: "Piper scout and Marty")

      get "/api/v1/items/find?name=Piper%20scout%20and%20Marty"

      expect(response.status).to eq 200

      item = JSON.parse(response.body)

      expect(item["name"]).to eq "Piper scout and Marty"
    end

    it "returns a random item" do
      item1, item2, item3 = create_list(:item, 3)
      items = [item1["id"], item2["id"], item3["id"]]

      get "/api/v1/items/random"

      random_item = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(items).to include(random_item[0]["id"])
    end

    it "returns all item by the same params" do
      item1 = create(:item, name: "Venice")
      item2 = create(:item, name: "Piper")
      item3 = create(:item, name: "Venice")

      get "/api/v1/items/find_all?name=Venice"

      expect(response.status).to eq 200

      result = JSON.parse(response.body)

      expect(result.count).to eq 2
      expect(result.first["name"]).to eq "Venice"
      expect(result.last["name"]).to eq "Venice"
    end

    it "returns a collection of associated invoice items" do
      item1, item2, item3 = create_list(:item, 3)
      invoice1, invoice2, invoice3 = create_list(:invoice, 3)
      item1.invoice_items.create(invoice_id: invoice1.id, quantity: 10, unit_price: 10.00)
      item2.invoice_items.create(invoice_id: invoice2.id, quantity: 10, unit_price: 10.00)
      item2.invoice_items.create(invoice_id: invoice3.id, quantity: 10, unit_price: 10.00)

      get "/api/v1/items/#{item2.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(invoice_items[0]["item_id"]).to eq item2.id
      expect(invoice_items[1]["item_id"]).to eq item2.id
      expect(invoice_items.count).to eq 2
    end

    it "returns the associated  merchant" do
      merchant1, merchant2 = create_list(:merchant, 2)
      item1 = merchant1.items.create(name: "lemon", description: "lemony", unit_price: 10.00)
      item2 = merchant2.items.create(name: "coxinha", description: "chickeny", unit_price: 50.00)

      get "/api/v1/items/#{item1.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response.status).to eq 200
    end
  end
end
