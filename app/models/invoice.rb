class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant

  validates :status, presence: true
end
