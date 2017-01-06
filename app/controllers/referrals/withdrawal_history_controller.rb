module Referrals
  class WithdrawalHistoryController < ApplicationController
    def index

    end

    private

    def current_user
      User.first
    end
  end
end