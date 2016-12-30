# @todo - make customizable if user can be assigned to other partner
module Referrals
  class AssignReferralToPartnerService
    private
    attr_reader :referral, :partner_id
    
    public
    
    def initialize(referral:, partner_id:)
      @referral = referral
      @partner_id = partner_id
    end

    def call
      partner.referrals << referral if valid?
    end

    private

    def partner
      # using find_by id to not raise exception when partner not found
      # possible scenario that user has old cookie and partner is no longer partner
      # so we don't want to raise exceptions on production because of such
      # scenario
      @partner ||= ::Referrals::Partner.find_by(id: partner_id)
    end

    def valid?
      partner && !user_already_assigned?
    end

    def user_already_assigned?
      ::Referrals::ReferralUser.where(referral: referral).count > 0
    end
  end
end