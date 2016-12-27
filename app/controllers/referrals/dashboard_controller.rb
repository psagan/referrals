module Referrals
  class DashboardController < ApplicationController
    def index
      @income_histories = Referrals::IncomeHistory.all
    end
  end
end