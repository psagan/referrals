module Referrals
  class IncomeHistoryController < ApplicationController
    include ::Referrals::FilterConcern
    before_action :set_filter_data

    def index
      @income_histories = ::Referrals::IncomeHistory
        .by_partner(current_user.partner)
        .by_date_from(@date_from)
        .by_date_to(@date_to)
        .page(@page)
    end

    def filter
      redirect_to income_history_index_path(date_from: @date_from, date_to: @date_to, page: @page)
    end

    private

    def current_user
      User.first
    end

  end
end