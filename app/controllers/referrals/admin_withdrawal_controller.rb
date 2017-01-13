module Referrals
  class AdminWithdrawalController < ApplicationController
    before_action :set_withdrawal, only: [:show, :update]
    before_action :set_filter_data, except: [:filter]

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
      redirect_to admin_withdrawal_index_path(date_from: get_date(:date_from), date_to: get_date(:date_to), status: params[:status])
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

    # @todo - move to concern
    def get_date(key)
      Date.parse(params[key])
    rescue
      nil
    end

    def set_filter_data
      @date_from = get_date(:date_from)
      @date_to = get_date(:date_to)
      @status = params[:status]
      @page = params[:page]
    end

  end
end