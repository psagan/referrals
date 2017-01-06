module Referrals
  class CreateWithdrawalService
    private
    attr_reader :partner, :amount

    public

    attr_reader :withdrawal

    def initialize(partner:, amount:)
      @partner = partner
      @amount = amount
    end

    def call
      partner.transaction do
        create_withdrawal && update_partner_amount
      end
    end

    private

    def create_withdrawal
      @withdrawal = ::Referrals::Withdrawal.new(
        amount: amount,
        partner: partner
      )
      withdrawal.save
    end

    def update_partner_amount
      partner.decrease_amount(@withdrawal.amount)
      partner.save
    end
  end
end