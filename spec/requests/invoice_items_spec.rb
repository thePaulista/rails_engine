require 'rails_helper'

describe "Invoice Items" do
  context "GET api/v1/invoice_items" do
    it "returns all the invoice items" do
      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items"

      expect(response.status).to eq 200

      invoices_items = JSON.parse(response.body)

      expect(invoices_items.count).to eq(3)
    end
  end

  it "returns one invoice item" do
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item1.id}"

    invoice_item1 = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(invoice_item1["quantity"]).to eq "1"
    expect(invoice_item1["unit_price"]).to eq "10"
   end

  it "returns invoice by a singular params" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?unit_price=10"

    expect(response.status).to eq 200

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["unit_price"]).to eq "10"
  end

  it "returns a random invoice item" do
    inv_item1, inv_item2, inv_item3 = create_list(:invoice_item, 3)
    invoice_items = [inv_item1["id"], inv_item2["id"], inv_item3["id"]]

    get "/api/v1/invoice_items/random"

    random_invoice_item = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(random_invoice_item.count).to eq 1
    expect(invoice_items).to include(random_invoice_item[0]["id"])
  end

  it "returns all invoice items by the same params" do
    invoice_item1 = create(:invoice_item, quantity: "1")
    invoice_item2 = create(:invoice_item, quantity: "3")
    invoice_item3 = create(:invoice_item, quantity: "1")

    get "/api/v1/invoice_items/find_all?quantity=1"

    result = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(result.first["quantity"]).to eq "1"
    expect(result.last["quantity"]).to eq "1"
  end

  it "returns the associated invoice" do
    customer1, customer2 = create_list(:customer, 2)
    merchant1, merchant2 = create_list(:merchant, 2)
    item1, item2 = create_list(:item, 2)
    invoice1, invoice2 = create_list(:invoice, 2)
    invoice_item1 = invoice1.invoice_items.create!(item_id: item1.id)
    invoice_item2 = invoice2.invoice_items.create(item_id: item2.id, unit_price: 10.00)

    get "/api/v1/invoice_items/#{invoice_item2.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(invoice["id"]).to eq invoice_item2.invoice_id
  end

  it "returns the associated item" do
    item1, item2 = create_list(:item, 2)
    invoice1, invoice2 = create_list(:invoice, 2)
    invoice_item1 = invoice1.invoice_items.create(item_id: item1.id, quantity: 10, unit_price: 10.00)
    invoice_item2 = invoice2.invoice_items.create(item_id: item2.id, quantity: 10, unit_price: 10.00)

    get "/api/v1/invoice_items/#{invoice_item2.id}/item"

    item = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(item["id"]).to eq invoice_item2.item["id"]
  end
end

