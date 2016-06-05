class InvoiceItem < ActiveRecord::Base
  before_save :convert_to_currency

  belongs_to :item
  belongs_to :invoice

  has_many :transactions, through: :invoice

  def convert_to_currency
    self.unit_price = self.unit_price.to_f / 100
  end
end
