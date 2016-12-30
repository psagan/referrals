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
      partner.transaction do
        create_income_history
        update_partner_amount
      end
    end

    private

    def partner
      @partner ||= referral.referral_user.try(:partner)
    end

    def create_income_history
      partner.income_histories.create(
          referral: referral,
          amount: amount,
          share: partner.share,
          share_amount: partner.share * amount,
          info: info
      )
    end

    def update_partner_amount
      partner.update(amount: partner.amount + amount)
    end
  end
end