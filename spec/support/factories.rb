FactoryGirl.define do

  factory :customer do |n|
    sequence(:first_name) {|n| "first_name #{n}" }
    sequence(:last_name) {|n| "last_name #{n}" }
  end

  factory :merchant do |n|
    sequence(:name) {|n| "Piper #{n}" }
  end

  factory :invoice do |n|
    customer
    merchant
    sequence(:status) {|n| "pending" }
  end

  factory :item do |n|
    sequence(:name) {|n| "coxinha #{n}" }
    sequence(:description) {|n| "last_name #{n}" }
    sequence(:unit_price) { 10 }
    merchant
  end

  factory :transaction do |n|
    sequence(:credit_card_number) {|n|"#{n}10#{n}" }
    sequence(:credit_card_expiration_date) {|n| "11/30 " }
    sequence(:result) { "successfull" }
    invoice
  end
end

