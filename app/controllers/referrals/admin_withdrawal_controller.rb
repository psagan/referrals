module Referrals
  class AdminWithdrawalController < ApplicationController

    def index
      @date_from = get_date(:date_from)
      @date_to = get_date(:date_to)
      @withdrawals = ::Referrals::Withdrawal
        .by_date_from(@date_from)
        .by_date_to(@date_to)
        .by_status(params[:status])
        .page(params[:page])
    end

    def filter
      redirect_to admin_withdrawal_index_path(date_from: get_date(:date_from), date_to: get_date(:date_to))
    end

    private

    # @todo - move to concern
    def get_date(key)
      Date.parse(params[key])
    rescue
      nil
    end

  end
end