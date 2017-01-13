module Referrals
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    private

    def current_user
      return User.first
      raise 'Need to be implemented in your app!'
    end
  end
end
