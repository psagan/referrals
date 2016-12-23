module Referrals
  module Referable
    extend ActiveSupport::Concern

    included do
      has_one :partnership, class_name: 'Referrals::Partner'
    end

    def partner?
      partnership.present?
    end

    def make_partner!
      Referrals::Partner.new(user: self).save unless partner?
    end
  end
end