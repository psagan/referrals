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
      capture_referral_action(referral: user, amount: 1000, info: 'Payment for subscription')
      render plain: 'ok'
    end
  end

  let!(:partner_user) { FactoryGirl.create(:user) }
  let!(:partner) { FactoryGirl.create(:partner, user: partner_user) }
  let!(:user) { FactoryGirl.create(:user, email: 'user@example.com') }

  describe "#assign_user_to_partner" do
    before do
      routes.draw { get 'fake_action' => 'anonymous#fake_action' }
      allow(Referrals::AssignReferralToPartnerService).to receive(:new).and_return(assign_referral_to_partner_service)
    end
    let(:assign_referral_to_partner_service) { double(:assign_referral_to_partner_service, call: true) }

    context "when referrals_pid in cookie" do
      before do
        request.cookies[:referrals_pid] = partner.id
      end

      it "calls service with proper arguments" do
        get 'fake_action'

        expected_arguments = {
            referral: user,
            partner_id: partner.id.to_s
        }
        expect(Referrals::AssignReferralToPartnerService).to have_received(:new).with(expected_arguments).once
        expect(assign_referral_to_partner_service).to have_received(:call).once
      end
    end

    context "when no referrals_pid info in cookie" do
      it "does not call  service" do
        get :fake_action

        expect(Referrals::AssignReferralToPartnerService).not_to have_received(:new)
        expect(assign_referral_to_partner_service).not_to have_received(:call)
      end
    end
  end

  describe "#capture_referral_action" do
    let(:amount) { 1000 }
    let(:info) { 'Payment for subscription' }
    let(:capture_referral_action_service) { double(:capture_referral_action_service, call: true) }

    before do
      routes.draw { get 'fake_action_2' => 'anonymous#fake_action_2' }
    end

    it "calls service with proper arguments" do
      allow(Referrals::CaptureReferralActionService).to receive(:new).and_return(capture_referral_action_service)
      get 'fake_action_2'

      expected_arguments = {
          referral: user,
          amount: amount,
          info: info
      }
      expect(Referrals::CaptureReferralActionService).to have_received(:new).with(expected_arguments).once
      expect(capture_referral_action_service).to have_received(:call).once
    end
  end

end