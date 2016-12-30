FactoryGirl.define do
  factory :income_history, class: 'Referrals::IncomeHistory' do
    association :partner
    association :referral
    info "Payment for subscription"
    amount_cents 1234
    share 0.50
    share_amount 617
  end
end
