module Referrals
  class IncomeHistory < ApplicationRecord
    include Filterable

    belongs_to :partner
    belongs_to :referral, class_name: Referrals.user_class, foreign_key: :user_id

    monetize :amount_cents, as: 'amount'
    monetize :share_amount_cents, as: 'share_amount'
  end
end
