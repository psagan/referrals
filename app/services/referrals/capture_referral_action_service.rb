module Referrals
  class CaptureReferralActionService

    private
    attr_reader :referral, :amount, :info

    public

    def initialize(referral:, amount:, info:)
      @referral = referral
      @amount = amount
      @info = info
    end

    def call

    end

    private
  end
end