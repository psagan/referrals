module Referrals
  module OperationsConcern

    private

    def assign_referral_to_partner(referral)
      return unless pid = cookies[:referrals_pid]
      # using find_by id to not raise exception when partner not found
      # possible scenario that user has old cookie and partner is no longer partner
      # so we don't want to raise exceptions on production because of such
      # scenario
      partner = ::Referrals::Partner.find_by(id: pid)
      # @todo - make customizable if user can be assigned to other partner
      partner.referrals << referral if partner && !::Referrals::ReferralUser.find_by(referral: referral)
    end
  end
end