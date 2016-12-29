module Referrals
  class IncomeHistory < ApplicationRecord
    belongs_to :partner
    belongs_to :referral, class_name: Referrals.user_class, foreign_key: :user_id

    scope :date_from, -> (date_from) { where('created_at >= ?', date_from.beginning_of_day) if date_from }
    scope :date_to, -> (date_to) { where('created_at <= ?', date_to.end_of_day) if date_to }
    scope :by_partner, -> (partner) { where(partner: partner) }

    monetize :amount_cents, as: 'amount'
    monetize :share_amount_cents, as: 'share_amount'
  end
end
