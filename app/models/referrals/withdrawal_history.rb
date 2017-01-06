module Referrals
  class WithdrawalHistory < ApplicationRecord
    belongs_to :withdrawal
  end
end
