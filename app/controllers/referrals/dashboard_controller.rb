module Referrals
  class DashboardController < ApplicationController
    include ::Referrals::UnauthorizedConcern

    before_action :unauthorized_unless_partner
    def index
      @partner = current_user.partner
    end
  end
end