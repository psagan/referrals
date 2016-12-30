require 'rails_helper'

RSpec.describe Referrals::CaptureReferralActionService do
  let(:amount) { 1000 }
  let(:info) { 'Payment for subscription' }
  let!(:partner_user) { FactoryGirl.create(:user) }
  let!(:partner) { FactoryGirl.create(:partner, user: partner_user) }
  let!(:user) { FactoryGirl.create(:user, email: 'user@example.com') }

  subject(:service) { described_class.new(amount: amount, referral: user, info: info) }

  describe "#call" do
    context "when referral is assigned to partner" do
      let!(:referral_user) { FactoryGirl.create('referral_user', referral: user, partner: partner) }
      it "creates income history" do
        expect { service.call }.to change { partner.income_histories.count }.by(1)
      end

      it "returns truthy result" do
        expect(service.call).to be_truthy
      end
    end

    context "when referral is NOT assigned to partner" do
      it "does not create income history" do
        expect { service.call }.to change { partner.income_histories.count }.by(0)
      end

      it "returns falsey result" do
        expect(service.call).to be_falsey
      end
    end

  end
end