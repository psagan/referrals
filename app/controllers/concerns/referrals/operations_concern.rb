module Referrals
  module OperationsConcern

    def assign_referral_to_partner(referral)
      return unless pid = cookies[:referrals_pid]
      partner = ::Referrals::Partner.find_by_id(pid)
      partner.referrals << referral if partner
    end
  end
end