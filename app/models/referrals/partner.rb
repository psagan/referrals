module Referrals
  class Partner < ApplicationRecord
    has_many :referral_users
    has_many :referrals, through: :referral_users
    belongs_to :user, class_name: Referrals.user_class, foreign_key: :user_id

    validates :user, uniqueness: true, presence: true
  end
end
