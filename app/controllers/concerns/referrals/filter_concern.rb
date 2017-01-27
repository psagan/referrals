module Referrals
  module FilterConcern

    private

    attr_reader :filter_data

    def set_filter_data
      @filter_data ||= ::Referrals::FilterDataDto.new(params).tap do |fd|
        fd.valid?
      end
    end
  end
end