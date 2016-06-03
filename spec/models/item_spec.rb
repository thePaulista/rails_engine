require 'rails_helper'

describe Item do
  context "associatons" do
    it { is_expected.to belong_to(:merchant) }
    it { is_expected.to have_many(:invoice_items) }
    it { is_expected.to have_many(:invoices) }
  end
end
