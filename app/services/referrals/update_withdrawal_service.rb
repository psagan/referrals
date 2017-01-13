module Referrals
  class UpdateWithdrawalService
    extend Forwardable
    private
    attr_reader :withdrawal, :status
    def_delegator :@withdrawal, :partner

    public

    def initialize(withdrawal:, status:)
      @withdrawal = withdrawal
      @status = status
    end

    def call
      return unless valid?
      withdrawal.transaction do
        handle_partner_amount
        add_history
        update_withdrawal
      end
    end

    private

    def valid?
      withdrawal.status != status && withdrawal.class.statuses.keys.include?(status)
    end

    def handle_partner_amount
      # if new state is 'cancelled' then we need to increase partne amount
      # as we give money back to partner
      partner.increase_amount(withdrawal.amount) if status == 'cancelled'
      # if previous state was cancelled then we need to decrease partner amount
      # as new state requires that
      partner.decrease_amount(withdrawal.amount) if withdrawal.cancelled?
      partner.save if partner.changed?
    end

    def add_history
      withdrawal.withdrawal_histories.create(
        status_from: withdrawal.status_number,
        status_to: withdrawal.status_number(status)
      )
    end

    def update_withdrawal
      withdrawal.send('%s!' % status)
    end

  end
end