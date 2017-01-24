module Referrals
  class WithdrawalHistory < ApplicationRecord
    belongs_to :withdrawal
    default_scope { order(created_at: :asc) }
  end
end
