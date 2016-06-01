class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :merchants, through: :invoices

end
