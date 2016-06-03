class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def revenue
    rev = invoices.
      joins(:invoice_items, :transactions).
      where(transactions: {result: "success"}).
      sum("invoice_items.quantity * invoice_items.unit_price")
    { revenue: rev }
  end

  def self.most_revenue(quantity)
    joins(:invoice_items)
      .group(:id)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .limit(quantity)
  end

  def revenue_by_date(date)
    rev = invoices
      .joins(:transactions, :invoice_items)
      .where(transactions: { result: "success" })
      .where(invoices: { created_at: date })
      .sum("invoice_items.unit_price * invoice_items.quantity")

    { "revenue" => rev }
  end

  def favorite_customer
    customers.select("customers.*, count(invoices.customer_id) AS invoice_count")
      .joins(invoices: :transactions)
      .where(transactions: { result: "success" })
      .group("customers.id")
      .order("invoice_count DESC")
      .first
  end

  def customers_with_pending_invoices
    customer_id =
      invoices.joins(:transactions)
      .where(transactions: { result: "failed" })
      .pluck(:customer_id)
    Customer.where(id: customer_id)
  end

  def self.most_items(quantity)
    select("merchants.*, sum(invoice_items.quantity) as item_count")
      .joins(:invoice_items)
      .group("merchants.id")
      .order("item_count desc")
      .limit(quantity)
end
end
