require 'rails_helper'

describe Merchant do
  context "associatons" do
    it { is_expected.to have_many(:invoice_items) }
    it { is_expected.to have_many(:invoices) }
    it { is_expected.to have_many(:items) }
    it { is_expected.to have_many(:customers) }
    it { is_expected.to have_many(:transactions) }
  end
end
