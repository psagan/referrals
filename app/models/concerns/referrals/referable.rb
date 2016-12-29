module Referrals
  module Referable
    extend ActiveSupport::Concern

    included do
      has_one :partner, class_name: 'Referrals::Partner'
      has_one :referral_user, class_name: "Referrals::ReferralUser"
    end

    def partner?
      partner.present?
    end

    def make_partner!
      Referrals::Partner.new(user: self).save unless partner?
    end
  end
end