module Referrals
  module CookiesConcern
    extend ActiveSupport::Concern

    included do
      before_action :handle_pid
    end

    private

    def handle_pid
      # @todo - make configurable name of parameter
      # @todo - make configurable override partner id
      if params[:pid] && !cookies[:referrals_pid] && partner
        cookies[:referrals_pid] = {
            value: partner.id,
            expires: 1.year.from_now #@todo -make configurable
        }
      end
    end

    def partner
      @partner ||= ::Referrals::Partner.find_by(id: params[:pid])
    end
  end
end