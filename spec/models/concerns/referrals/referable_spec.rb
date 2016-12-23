require 'rails_helper'

# This tests are related to model concern.
# We have User model in dummy app which includes
# Referrals::Referable module so I'm using
# this ActiveRecord model to test Referrals::Referable.
RSpec.describe Referrals::Referable, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  describe "#partner?" do
    context "when user is partner" do
      before do
        FactoryGirl.create(:partner, user: user)
      end

      it "returns true" do
        expect(user.partner?).to eq(true)
      end
    end

    context "when user is not partner" do
      it "returns false" do
        expect(user.partner?).to eq(false)
      end
    end
  end

  describe "#make_partner!" do
    context "when user is not partner yet" do
      it "adds user to partners" do
        expect { user.make_partner! }.to change { Referrals::Partner.count }.by(1)
        expect(Referrals::Partner.first.user).to eq(user)
      end
    end

    context "when user is partner already" do
      before do
        FactoryGirl.create(:partner, user: user)
      end
      it "does not create another partner record" do
        expect { user.make_partner! }.to change { Referrals::Partner.count }.by(0)
      end
    end
  end

end