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
        update_withdrawal
        # @todo - add withdrawal history
      end
    end

    private

    def valid?
      withdrawal.status != status && withdrawal.class.statuses.keys.include?(status)
    end

    def handle_partner_amount
      partner.decrease_amount(withdrawal.amount) if withdrawal.cancelled?
      partner.increase_amount(withdrawal.amount) if status == 'cancelled'
      partner.save if partner.changed?
    end

    def update_withdrawal
      withdrawal.send('%s!' % status)
    end

  end
end