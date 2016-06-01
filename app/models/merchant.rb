class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :customer, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
end
