module Referrals
  module OperationsConcern

    def assign_referral_to_partner(referral)
      return unless pid = cookies[:referrals_pid]
      # using find_by id to not raise exception when partner not found
      # possible scenario that user has old cookie and partner is no longer partner
      # so we don't want to raise exceptions on production because of such
      # scenario
      partner = ::Referrals::Partner.find_by(id: pid)
      partner.referrals << referral if partner
    end
  end
end