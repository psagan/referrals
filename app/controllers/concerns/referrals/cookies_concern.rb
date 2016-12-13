module Referrals
  module CookiesConcern
    extend ActiveSupport::Concern

    included do
      before_action :handle_pid
    end

    private

    def handle_pid
      # @todo - make configurable
      if params[:pid] && !cookies[:referrals_pid]
        cookies[:referrals_pid] = {
            value: params[:pid],
            expires: 1.year.from_now #@todo -make configurable
        }
      end
    end
  end
end