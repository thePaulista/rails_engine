class Item < ActiveRecord::Base
  before_save :convert_to_currency

  belongs_to :merchant
  has_many :invoice_items

  def convert_to_currency
    self.unit_price = self.unit_price.to_f/100
    #sprintf('%.02f', (self.unit_price / 100.0))
  end
end
