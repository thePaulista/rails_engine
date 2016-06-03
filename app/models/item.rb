class Item < ActiveRecord::Base
  before_create :convert_to_currency

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def convert_to_currency
    num = self.unit_price.to_f / 100
    self.unit_price  =  sprintf("%.2f", num)
  end

  def self.most_revenue(quantity)
    joins(invoice_items: :transactions)
      .where("transactions.result = 'success'")
      .group(:id)
      .order("sum(invoice_items.unit_price * invoice_items.quantity) desc")
      .limit(quantity.to_i)
  end

  def self.most_items(quantity)
    joins(invoice_items: :transactions)
      .where("transactions.result = 'success'")
      .group(:id)
      .order("sum(invoice_items.quantity) desc")
      .limit(quantity.to_i)
  end

  def best_day
    invoice_items.joins(:transactions)
      .where(transactions: { result:  'success' })
      .order(quantity: :desc).take(2)
      .first.invoice.created_at
  end
end
