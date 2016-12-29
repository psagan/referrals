module Referrals
  class IncomeHistoryController < ApplicationController
    def index
      @date_from = get_date(:date_from)
      @date_to = get_date(:date_to)
      @income_histories = Referrals::IncomeHistory
        .by_partner(current_user.partnership)
        .date_from(@date_from)
        .date_to(@date_to)
        .page(params[:page])

    end

    def filter
      redirect_to income_history_index_path(date_from: get_date(:date_from), date_to: get_date(:date_to))
    end

    private

    def current_user
      User.first
    end

    def get_date(key)
      Date.parse(params[key])
    rescue
      nil
    end
  end
end