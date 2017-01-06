module Referrals
  class WithdrawalController < ApplicationController
    def index

    end

    def new
      @withdrawal = ::Referrals::Withdrawal.new
      @partner = current_user.partner
    end

    private

    def current_user
      User.first
    end
  end
end