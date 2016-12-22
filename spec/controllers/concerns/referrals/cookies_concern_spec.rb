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
        expect(response.cookies['referrals_pid']).to eq(nil)
      end
    end

    context "when pid in request" do
      context "when no cookie set" do
        context "when partner exists" do
          let!(:partner) { FactoryGirl.create(:partner) }

          it "set cookie value to partner id" do
            get :fake_action, params: { pid: partner.id }

            expected = {
                value: partner.id,
                expires: 1.year.from_now
            }
            expect(response.cookies['referrals_pid']).to eq(partner.id.to_s)
          end

          it "set cookie expiration time" do
            date = 1.year.from_now
            allow_any_instance_of(ActiveSupport::Duration).to receive(:from_now).and_return(date)
            # thanks to http://bit.ly/2hXQka9
            stub_cookie_jar = HashWithIndifferentAccess.new
            allow(controller).to receive(:cookies).and_return(stub_cookie_jar)

            get :fake_action, params: { pid: partner.id }

            expect(stub_cookie_jar['referrals_pid'][:expires]).to eq(date)
          end

        end

        context "when partner does not exist" do
          it "does not set cookie" do
            get :fake_action, params: { pid: 7 }

            expect(response.cookies['referrals_pid']).to eq(nil)
          end
        end
      end

      context "when cookie set" do

      end
    end

    context "when no pid in request" do

    end
  end
end