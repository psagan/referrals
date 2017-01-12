FactoryGirl.define do
  factory :withdrawal_history, class: 'Referrals::WithdrawalHistory' do
    association :withdrawal
    status_from 1
    status_to 1
  end
end
