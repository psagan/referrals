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
        (create_withdrawal && add_history && update_partner_amount).tap do |result|
          Referrals::Events.after_withdrawal_create.call(self) if result
        end
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

    def add_history
      withdrawal.withdrawal_histories.create!(
        status_to: withdrawal.status_number
      )
    end

    def update_partner_amount
      partner.decrease_amount(@withdrawal.amount)
      partner.save
    end
  end
end