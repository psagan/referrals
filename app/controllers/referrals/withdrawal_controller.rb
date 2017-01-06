module Referrals
  class WithdrawalController < ApplicationController
    before_action :set_partner, only: [:new, :create]

    def index

    end

    def new
      @withdrawal = ::Referrals::Withdrawal.new

    end

    def create
      #@todo - move to dedicated service
      @withdrawal = ::Referrals::Withdrawal.new(withdrawal_params)
      if @withdrawal.save
        redirect_to action: :index
      else
        render action: :new
      end
    end

    private

    def set_partner
      @partner = current_user.partner
    end

    def withdrawal_params
      params.require(:withdrawal).permit(:amount).merge(partner: @partner)
    end

    def current_user
      User.first
    end
  end
end