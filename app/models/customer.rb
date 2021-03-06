class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants.select("merchants.*, count(invoices.merchant_id) AS inv_count")
                        .joins(invoices: :transactions)
                        .group("merchants.id")
                        .order("inv_count DESC")
                        .first
  end
end
