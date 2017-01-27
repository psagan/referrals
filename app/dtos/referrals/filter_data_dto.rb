module Referrals
  class FilterDataDto
    include ActiveModel::Validations

    AVAILABLE_FIELDS = %i{date_from date_to status page}.freeze

    attr_reader *AVAILABLE_FIELDS

    validate :date_range_possible?
    
    def initialize(params)
      @date_from = get_date(params[:date_from])
      @date_to = get_date(params[:date_to])
      @status = params[:status]
      @page = params[:page]
    end

    def to_h
      AVAILABLE_FIELDS.inject({}) do |container, field|
        container.tap {|c| c[field] = send(field) unless send(field).blank? }
      end
    end

    private

    def date_range_possible?
      return if date_from.blank? || date_to.blank?
      if date_from > date_to
        errors.add(:date_to, 'must be greater than date to') # @todo - I18n
      end
    end

    def get_date(date)
      Date.parse(date)
    rescue
      nil
    end

  end
end