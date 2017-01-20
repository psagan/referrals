module Referrals
  class DashboardController < ApplicationController
    include ::Referrals::UnauthorizedConcern
    include ::Referrals::LayoutConcern

    before_action :unauthorized_unless_partner
    def index
      @partner = current_user.partner
    end
  end
end