require 'rails_helper'

RSpec.describe Referrals::AssignReferralToPartnerService do
  let!(:partner_user) { FactoryGirl.create(:user) }
  let!(:partner) { FactoryGirl.create(:partner, user: partner_user) }
  let!(:user) { FactoryGirl.create(:user, email: 'user@example.com') }
  let(:partner_id) { partner.id }

  subject(:service) { described_class.new(referral: user, partner_id: partner_id) }

  describe "#call" do
    context "when not proper partner_id" do
      let(:partner_id) { 0 }

      it "does not assign user to partner" do
        expect { service.call }.to change { Referrals::ReferralUser.count }.by(0)
      end
    end

    context "when user is not yet assigned to partner" do
      it "adds new referral user" do
        expect { service.call }.to change { Referrals::ReferralUser.count }.by(1)
      end

      it "adds user to partner" do
        service.call

        expect(partner.referrals.first).to eq(user)
      end
    end

    context "when user is already assigned to partner" do
      let!(:referral_user) { FactoryGirl.create('referral_user', referral: user, partner: partner) }
      it "does not assign it once again" do
        expect { service.call }.to change { Referrals::ReferralUser.count }.by(0)
      end
    end

    context "when user is assigned to other partner" do
      let!(:partner_user_2) { FactoryGirl.create(:user) }
      let!(:partner_2) { FactoryGirl.create(:partner, user: partner_user_2) }
      let!(:referral_user) { FactoryGirl.create('referral_user', referral: user, partner: partner_2) }
      it "does not assign user to new partner" do
        expect { service.call }.to change { Referrals::ReferralUser.count }.by(0)
      end
    end

  end
end