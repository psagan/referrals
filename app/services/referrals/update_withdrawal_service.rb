module Referrals
  class UpdateWithdrawalService
    private
    attr_reader :withdrawal, :status

    public

    def initialize(withdrawal:, status:)
      @withdrawal = withdrawal
      @status = status
    end

    def call
      withdrawal.transaction do
        update_withdrawal
        # @todo - handle partner accout
      end
    end

    private

    def update_withdrawal
      case status
        when 'pending' then withdrawal.pending!
        when 'paid' then withdrawal.paid!
        when 'cancelled' then withdrawal.cancelled!
      end
    end


  end
end