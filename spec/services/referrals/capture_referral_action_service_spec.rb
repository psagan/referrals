require 'rails_helper'

RSpec.describe Referrals::CaptureReferralActionService do
  let(:amount) { Money.new(1034) }
  let(:info) { 'Payment for subscription' }
  let!(:partner_user) { FactoryGirl.create(:user) }
  let!(:partner) { FactoryGirl.create(:partner, user: partner_user, amount: Money.new(2748)) }
  let!(:user) { FactoryGirl.create(:user, email: 'user@example.com') }

  subject(:service) { described_class.new(amount: amount, referral: user, info: info) }

  describe "#call" do
    context "when referral is assigned to partner" do
      let!(:referral_user) { FactoryGirl.create('referral_user', referral: user, partner: partner) }
      it "creates income history" do
        expect { service.call }.to change { partner.income_histories.count }.by(1)
      end

      it "updates partner amount" do
        expect { service.call }.to change { partner.reload.amount_cents }.by(1034)
        expect(partner.reload.amount).to eq(Money.new(3782))
      end
    end

    context "when referral is NOT assigned to partner" do
      it "does not create income history" do
        expect { service.call }.to change { partner.income_histories.count }.by(0)
      end

      it "does not update partner amount" do
        expect { service.call }.to change { partner.reload.amount_cents }.by(0)
        expect(partner.reload.amount).to eq(Money.new(2748))
      end

      it "returns falsey result" do
        expect(service.call).to be_falsey
      end
    end

  end
end