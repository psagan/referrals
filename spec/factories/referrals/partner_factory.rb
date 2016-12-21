FactoryGirl.define do
  factory :partner, class: Referrals::Partner do
    share 0.5
    amount 100
    association :user
  end
end