module Referrals
  class Partner < ApplicationRecord
    has_many :referrals_referral_users
    has_many :referrals, through: :referrals_referral_users
    belongs_to :user, class_name: Partners.user_class, foreign_key: :user_id

    validates :user, uniqueness: true, presence: true
  end
end
