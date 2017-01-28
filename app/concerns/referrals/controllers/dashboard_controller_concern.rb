module Referrals
  module Controllers
    module DashboardControllerConcern
      extend ActiveSupport::Concern

      included do
        include ::Referrals::UnauthorizedConcern
        include ::Referrals::LayoutConcern
        before_action :unauthorized_unless_partner
      end

      def index
        @partner = current_user.partner
      end
    end
  end
end
