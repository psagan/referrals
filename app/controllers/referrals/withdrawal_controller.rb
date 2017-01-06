module Referrals
  class WithdrawalController < ApplicationController
    before_action :set_partner, only: [:index, :new, :create]

    def index
      @withdrawals = ::Referrals::Withdrawal.by_partner(@partner)
    end

    def new
      @withdrawal = ::Referrals::Withdrawal.new

    end

    def create
      if create_service.call
        redirect_to action: :index
      else
        @withdrawal = create_service.withdrawal
        render action: :new
      end
    end

    private

    def set_partner
      @partner = current_user.partner
    end

    def withdrawal_params
      params.require(:withdrawal).permit(:amount)
    end

    def create_service
      @create_service ||= ::Referrals::CreateWithdrawalService.new(amount: withdrawal_params[:amount], partner: @partner)
    end

    def current_user
      User.first
    end
  end
end