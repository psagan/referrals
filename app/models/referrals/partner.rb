module Referrals
  class Partner < ApplicationRecord
    has_many :referral_users
    has_many :referrals, through: :referral_users
    has_many :withdrawals
    belongs_to :user, class_name: Referrals.user_class, foreign_key: :user_id
    has_many :income_histories

    validates :user, uniqueness: true, presence: true

    monetize :amount_cents, as: 'amount'
  end
end
