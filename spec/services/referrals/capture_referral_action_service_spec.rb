require 'rails_helper'

RSpec.describe Referrals::CaptureReferralActionService do

  shared_examples :changes_in_partner_amount do |by_value, amount_value|
    it "changes partner amount" do
      expect { service.call }.to change { partner.reload.amount_cents }.by(by_value)
      expect(partner.reload.amount).to eq(Money.new(amount_value))
    end
  end

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

      it_behaves_like :changes_in_partner_amount, 1034, 3782
    end

    context "when referral is NOT assigned to partner" do
      it "does not create income history" do
        expect { service.call }.to change { partner.income_histories.count }.by(0)
      end

      it_behaves_like :changes_in_partner_amount, 0, 2748

      it "returns falsey result" do
        expect(service.call).to be_falsey
      end
    end

  end
end