module Referrals
  module OperationsConcern

    def assign_referral_to_partner(referral)
      return unless pid = cookies[:referrals_pid]
      # using find_by_id
      partner = ::Referrals::Partner.find_by(id: pid)
      partner.referrals << referral if partner
    end
  end
end