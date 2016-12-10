module Referrals
  class ReferralUser < ApplicationRecord
    belongs_to :partner
    belongs_to :user, class_name: Partners.user_class, foreign_key: :user_id

    validates :user, uniqueness: true, presence: true
    validates :partner, presence: true
  end
end
