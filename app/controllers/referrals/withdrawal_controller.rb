module Referrals
  class WithdrawalController < ApplicationController
    def index

    end

    def new

    end

    private

    def current_user
      User.first
    end
  end
end