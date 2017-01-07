module Referrals
  class AdminWithdrawalController < ApplicationController

    def index
      @date_from = get_date(:date_from)
      @date_to = get_date(:date_to)
      @status = params[:status]
      @withdrawals = ::Referrals::Withdrawal
        .by_date_from(@date_from)
        .by_date_to(@date_to)
        .by_status(@status)
        .page(params[:page])
    end

    def update
      # @todo - move to dedicated service
      w = ::Referrals::Withdrawal.find(params[:id])
      case params[:withdrawal][:status]
        when 'pending' then w.pending!
        when 'cancelled' then w.cancelled!
        when 'paid' then w.paid!
      end
      filter
    end

    def filter
      redirect_to admin_withdrawal_index_path(date_from: get_date(:date_from), date_to: get_date(:date_to), status: params[:status])
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