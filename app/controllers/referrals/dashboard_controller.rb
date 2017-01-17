module Referrals
  class DashboardController < ApplicationController
    def index
      @partner = current_user.partner
    end
  end
end