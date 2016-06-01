FactoryGirl.define do

  factory :customer do |n|
    sequence(:first_name) {|n| "first_name #{n}" }
    sequence(:last_name) {|n| "last_name #{n}" }
  end


end

