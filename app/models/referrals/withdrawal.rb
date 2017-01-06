module Referrals
  class Withdrawal < ApplicationRecord
    belongs_to :partner

    # it would be great to keep this in jsonb field
    # but use has_many relationship for versatility
    has_many :withdrawal_histories

    enum status: { pending: 0, paid: 1, cancelled: 2 }
  end
end
