module Referrals
  module Filterable
    extend ActiveSupport::Concern

    included do
      scope :by_date_from, -> (date_from) { where('created_at >= ?', date_from.beginning_of_day) if date_from }
      scope :by_date_to, -> (date_to) { where('created_at <= ?', date_to.end_of_day) if date_to }
      scope :by_partner, -> (partner) { where(partner: partner) }
    end

    # def filter(partner:, date_from:, date_to:)
    #   # @todo - add one method to not duplicate in controllers
    # end
  end
end