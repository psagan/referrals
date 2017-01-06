module Referrals
  class Withdrawal < ApplicationRecord
    enum status: { pending: 0, paid: 1, cancelled: 2 }
  end
end
