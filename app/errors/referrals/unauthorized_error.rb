module Referrals
  class UnauthorizedError < StandardError
    attr_reader :status_code

    def initialize(msg)
      @status_code = 401
      super
    end
  end
end