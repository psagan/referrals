require 'rails_helper'

RSpec.describe Referrals::CookiesConcern, type: :controller do
  controller(ApplicationController) do
    include Referrals::CookiesConcern

    def fake_action; render plain: 'ok'; end
  end
  before do
    routes.draw { get 'fake_action' => 'anonymous#fake_action' }
  end

  describe '#handle_pid' do
    context "when no pid in request" do
      before { get :fake_action }
      it "does not set referral cookie" do
        expect(response.cookies[:referrals_pid]).to eq(nil)
      end
    end

    context "when pid in request" do
      context "when no cookie set" do
        context "when partner exists" do
          it "" do
            FactoryGirl.create(:partner)
          end
        end

        context "when partner does not exist" do

        end
      end

      context "when cookie set" do

      end
    end
  end
end