module Referrals
  class IncomeHistory < ApplicationRecord
    belongs_to :partner
    belongs_to :referral, class_name: Referrals.user_class, foreign_key: :user_id
  end
end
