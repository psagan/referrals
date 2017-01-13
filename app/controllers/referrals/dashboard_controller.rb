module Referrals
  class DashboardController < ApplicationController
    include ::Referrals::CurrentUserConcern
    def index
      @partner = current_user.partner
    end
  end
end