class Item < ActiveRecord::Base
  before_create :convert_to_currency

  belongs_to :merchant
  has_many :invoice_items

  def convert_to_currency
    self.unit_price = (unit_price.to_f / 100)
  end
end
