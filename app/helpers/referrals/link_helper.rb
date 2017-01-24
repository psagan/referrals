module Referrals
  module LinkHelper
    def referral_link(partner)
      # @todo - make configurable host and pid, if not config option use default
      # @todo - use request.protocol + request.host when no config option defined
      request.protocol + request.host.chomp('/') + '?pid=' + partner.id.to_s
    end
  end
end