require 'rails_helper'

describe "Invoice Item" do
  context "GET api/v1/invoice_items" do
    it "returns all invoice_items" do
      inv1 =  Invoice.create!(id: 1)
      inv2 = Invoice.create!(id: 2)
      invoice_item1 = InvoiceItem.create(invoice_id: inv1.id)
      invoice_item2 = InvoiceItem.create(invoice_id: inv2.id)

      get "/api/v1/invoice_items"

      expect(response.status).to eq 200

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(2)
    end
  end
end
