module Referrals
  class IncomeHistoryController < ApplicationController
    include ::Referrals::FilterConcern
    include ::Referrals::UnauthorizedConcern
    include ::Referrals::LayoutConcern

    before_action :unauthorized_unless_partner
    before_action :set_filter_data

    def index
      @income_histories = ::Referrals::IncomeHistory
        .by_partner(current_user.partner)
        .by_date_from(filter_data.date_from)
        .by_date_to(filter_data.date_to)
        .page(filter_data.page)
        .order('created_at DESC')
    end

    def filter
      redirect_to income_history_index_path(filter_data.to_h)
    end

  end
end