FactoryGirl.define do
  factory :referral_user, class: Referrals::ReferralUser do
    association :referral
    association :partner
  end
end