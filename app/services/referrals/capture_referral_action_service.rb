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
      return unless partner
      partner.income_histories.create(
          referral: referral,
          amount: amount,
          share: partner.share,
          share_amount: partner.share * amount,
          info: info
      )
    end

    private

    def partner
      referral.referral_user.try(:partner)
    end
  end
end