module Referrals
  class AdminWithdrawalController < ApplicationController
    include ::Referrals::AdminConcern
    include ::Referrals::FilterConcern

    before_action :set_withdrawal, only: [:show, :update]
    before_action :set_filter_data
    before_action :unauthorized_unless_admin

    def index
      @withdrawals = ::Referrals::Withdrawal
        .by_date_from(@date_from)
        .by_date_to(@date_to)
        .by_status(@status)
        .page(@page)
    end

    def update
      ::Referrals::UpdateWithdrawalService.new(
          withdrawal: @withdrawal,
          status: withdrawal_params[:status]
      ).call
      filter
    end

    def filter
      redirect_to admin_withdrawal_index_path(date_from: @date_from, date_to: @date_to, status: @status, page: @page)
    end

    def show
    end

    private

    def withdrawal_params
      params.require(:withdrawal).permit(:status)
    end

    def set_withdrawal
      @withdrawal = ::Referrals::Withdrawal.find(params[:id])
    end

  end
end