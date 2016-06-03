require 'rails_helper'

describe Customer do
  context "have many associatons" do
    it { is_expected.to have_many(:invoices) }
    it { is_expected.to have_many(:transactions) }
    it { is_expected.to have_many(:merchants) }
  end
end
