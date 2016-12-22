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
    let(:stub_cookies) { HashWithIndifferentAccess.new }

    context "when no pid in request" do
      before { get :fake_action }
      it "does not set referral cookie" do
        expect(response.cookies['referrals_pid']).to eq(nil)
      end
    end

    context "when pid in request" do
      context "when no cookie set" do
        context "when partner exists" do
          let!(:partner) { FactoryGirl.create(:partner) }

          it "set cookie value to partner id" do
            get :fake_action, params: { pid: partner.id }

            expect(response.cookies['referrals_pid']).to eq(partner.id.to_s)
          end

          it "set cookie expiration time" do
            date = 1.year.from_now
            allow_any_instance_of(ActiveSupport::Duration).to receive(:from_now).and_return(date)
            allow(controller).to receive(:cookies).and_return(stub_cookies)

            get :fake_action, params: { pid: partner.id }

            expect(stub_cookies['referrals_pid'][:expires]).to eq(date)
          end

        end

        context "when partner does not exist" do
          it "does not set cookie" do
            get :fake_action, params: { pid: 7 }

            expect(response.cookies['referrals_pid']).to eq(nil)
          end
        end
      end

      context "when cookie already set" do
        let!(:partner) { FactoryGirl.create(:partner) }
        before do
          stub_cookies[:referrals_pid] = { value: 10 }
          allow(controller).to receive(:cookies).and_return(stub_cookies)
        end

        it "does not overwrite the value" do
          get :fake_action, params: { pid: partner.id }

          expect(stub_cookies[:referrals_pid][:value]).to eq(10)
        end
      end
    end

  end
end