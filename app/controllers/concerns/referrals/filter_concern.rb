module Referrals
  module FilterConcern

    private

    def set_filter_data
      @date_from = get_date(:date_from)
      @date_to = get_date(:date_to)
      @status = params[:status]
      @page = params[:page]
    end

    def get_date(key)
      Date.parse(params[key])
    rescue
      nil
    end
  end
end