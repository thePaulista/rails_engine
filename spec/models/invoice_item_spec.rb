require 'rails_helper'

describe InvoiceItem do
  context "associatons" do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:invoice) }
  end
end
