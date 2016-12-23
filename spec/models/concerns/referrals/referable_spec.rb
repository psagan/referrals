require 'rails_helper'

# This tests are related to model concern.
# We have User model in dummy app which includes
# Referrals::Referable module so I'm using
# this ActiveRecord model to test Referrals::Referable.
RSpec.describe Referrals::Referable, type: :model do

  describe "#partner?" do
    let(:user) { FactoryGirl.create(:user) }
    context "when user is partner" do
      before do
        Referrals::Partner.new(user: user).save
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

end