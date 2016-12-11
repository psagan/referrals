module Referrals
  class ReferralUser < ApplicationRecord
    belongs_to :partner
    belongs_to :referral, class_name: Referrals.user_class, foreign_key: :user_id

    validates :referral, uniqueness: true, presence: true
    validates :partner, presence: true
  end
end
