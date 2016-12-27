require 'rails_helper'

RSpec.describe Referrals::OperationsConcern, type: :controller do
  controller(ApplicationController) do
    include Referrals::OperationsConcern

    def fake_action
      user = User.find_by_email('user@example.com')
      assign_referral_to_partner(user)
      render plain: 'ok'
    end

    def fake_action_2
      user = User.find_by_email('user@example.com')
      capture_referral_action(user, 1000, 'Payment for subscription')
      render plain: 'ok'
    end
  end
  before do
    routes.draw { get 'fake_action' => 'anonymous#fake_action' }
    routes.draw { get 'fake_action_2' => 'anonymous#fake_action_2' }
  end
  let!(:partner_user) { FactoryGirl.create(:user) }
  let!(:partner) { FactoryGirl.create(:partner, user: partner_user) }
  let!(:user) { FactoryGirl.create(:user, email: 'user@example.com') }

  describe "#assign_user_to_partner" do
    context "when referrals_pid in cookie" do
      before do
        request.cookies[:referrals_pid] = Referrals::Partner.first.id
      end

      context "when user is not yet assigned to partner" do
        it "assigns user to partner" do
          expect { get :fake_action }.to change{ partner.referrals.count }.by(1)
        end
      end

      context "when user is already assigned to partner" do
        let!(:referral_user) { FactoryGirl.create('referral_user', referral: user, partner: partner) }
        it "does not assign it once again" do
          expect { get :fake_action }.to change{ ::Referrals::ReferralUser.count }.by(0)
        end
      end

      context "when user is assigned to other partner" do
        let!(:partner_user_2) { FactoryGirl.create(:user) }
        let!(:partner_2) { FactoryGirl.create(:partner, user: partner_user_2) }
        let!(:referral_user) { FactoryGirl.create('referral_user', referral: user, partner: partner_2) }
        it "does not assign user to new partner" do
          expect { get :fake_action }.to change{ ::Referrals::ReferralUser.count }.by(0)
        end
      end
    end

    context "when no referrals_pid info in cookie" do
      it "does not assign" do
        get :fake_action

        expect(partner.referrals.count).to eq(0)
      end
    end
  end

  describe "#capture_referral_action" do
    let(:amount) { 1000 }
    let(:info) { 'Payment for subscription' }

    context "when referral is assigned to partner" do
      let!(:referral_user) { FactoryGirl.create('referral_user', referral: user, partner: partner) }
      it "creates income history" do
        expect { get :fake_action_2 }.to change { partner.income_histories.count }.by(1)
      end
    end

    context "when referral is NOT assigned to partner" do
      it "does not create income history" do
        expect { get :fake_action_2 }.to change { partner.income_histories.count }.by(0)
      end
    end
  end

end