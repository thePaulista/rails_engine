class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def revenue
    invoices.
      joins(:invoice_items, :transactions).
      where(transactions: {result: "success"}).
      sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def revenue_by_date(date)
    invoices
      .joins(:transactions, :invoice_items)
      .where(invoices: { created_at: date })
      .where(transactions: { result: "success" })
      .sum("invoice_items.unit_price * invoice_items.quantity")
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
    Customer.find(customer_id)
  end
end
