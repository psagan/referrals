module Referrals
  module LinkHelper
    def referral_link(partner)
      # @todo - make configurable
      request.protocol + request.host.chomp('/') + '/?pid=' + partner.id.to_s
    end
  end
end