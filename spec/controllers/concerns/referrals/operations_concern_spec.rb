require 'rails_helper'

RSpec.describe Referrals::OperationsConcern, type: :controller do
  controller(ApplicationController) do
    include Referrals::OperationsConcern

    def fake_action
      user = User.find_by_email('user@example.com')
      assign_referral_to_partner(user)
      render plain: 'ok'
    end
  end
  before do
    routes.draw { get 'fake_action' => 'anonymous#fake_action' }
  end

  describe "#assign_user_to_partner" do
    let!(:partner_user) { FactoryGirl.create(:user) }
    let!(:partner) { FactoryGirl.create(:partner, user: partner_user) }
    let!(:user) { FactoryGirl.create(:user, email: 'user@example.com') }


    context "when referrals_pid in cookie" do
      before do
        request.cookies[:referrals_pid] = Referrals::Partner.first.id
      end

      context "when user is not yet assigned to partner" do
        it "assigns user to partner" do
          expect { get :fake_action }.to change{ partner.referrals.count }.by(1)
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

end