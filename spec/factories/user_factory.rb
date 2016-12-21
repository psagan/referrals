FactoryGirl.define do
  factory :user do
    sequence(:email) { |n|  "x#{n}@example.com" }
  end
end