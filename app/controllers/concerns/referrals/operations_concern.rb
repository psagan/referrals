module Referrals
  module OperationsConcern

    private

    def assign_referral_to_partner(referral)
      return unless cookies[:referrals_pid]
      ::Referrals::AssignReferralToPartnerService.new(
        referral: referral,
        partner_id: cookies[:referrals_pid]
      ).call
    end

    def capture_referral_action(referral:, amount:, info:)
      ::Referrals::CaptureReferralActionService.new(
          referral: referral,
          amount: amount,
          info: info
      ).call
    end
  end
end