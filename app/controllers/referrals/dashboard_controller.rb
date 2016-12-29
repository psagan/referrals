module Referrals
  class DashboardController < ApplicationController
    def index
      @partner = current_user.partner
    end

    private

    def current_user
      User.first
    end
  end
end