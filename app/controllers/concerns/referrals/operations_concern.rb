module Referrals
  module OperationsConcern

    def assign_referral_to_partner(referral)
      return unless pid = cookies[:referrals_pid]
      partner = ::Referrals::Partner.find(pid)
      partner.referrals << referral
    end
  end
end