module Referrals
  class Withdrawal < ApplicationRecord
    include Filterable

    belongs_to :partner

    # it would be great to keep this in jsonb field
    # but decided to use has_many relationship for versatility
    # (more relational db's can use it)
    has_many :withdrawal_histories

    enum status: { pending: 0, paid: 1, cancelled: 2 }

    monetize :amount_cents, as: 'amount'

    validates :amount, :partner, presence: true
    validate :amount_value

    scope :by_status, -> (status) do
      where(status: statuses[status.to_sym]) unless status.blank?
    end

    def status_number(val = status)
      self.class.statuses[val]
    end

    private

    def amount_value
      if partner.amount < amount
        errors.add(:amount, :greater_thant_available_funds,count: partner.amount)
      end

      if min_withdrawal_amount && amount < min_withdrawal_amount
        errors.add(:amount, :less_than_min_withdrawal_amount, count: min_withdrawal_amount)
      end
    end

    def min_withdrawal_amount
      Referrals.min_withdrawal_amount ? Money.new(Referrals.min_withdrawal_amount) : nil
    end

  end
end
