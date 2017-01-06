FactoryGirl.define do
  factory :withdrawal, class: 'Referrals::Withdrawal' do
    association :partner
    amount_cents 1
    status 1
  end
end
