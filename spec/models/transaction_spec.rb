require 'rails_helper'

describe Transaction do
  context "associatons" do
    it { is_expected.to belong_to(:invoice) }
  end
end
