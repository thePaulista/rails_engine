FactoryGirl.define do
  factory :item do |n|
    sequence(:name) {|n| "name #{n}" }
    sequence(:description) {|n| "description #{n}" }
    sequence(:unit_price) {|n| "1.00" }
    merchant
  end

  factory :merchant do |n|
    sequence(:name) { |n| "bridget #{n}" }
  end

  factory :customer do |n|
    sequence(:first_name) { |n| "bridget #{n}" }
    sequence(:last_name) { |n| "jones #{n}" }
  end
end


