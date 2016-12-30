require 'rails_helper'
require 'support/shared/monetize_attr'

module Referrals
  RSpec.describe IncomeHistory, type: :model do

    describe "#amount" do
      include_examples :monetize_attr, :amount
    end

    describe "#share_amount" do
      include_examples :monetize_attr, :share_amount
    end

    describe "scopes" do
      let!(:partner_user) { FactoryGirl.create(:user) }
      let!(:partner) { FactoryGirl.create(:partner, user: partner_user) }
      let!(:user) { FactoryGirl.create(:user, email: 'user@example.com') }

      describe ".date_from" do
        let!(:income_history_1) { FactoryGirl.create(:income_history, partner: partner, referral: user, created_at: 2.months.ago) }
        let!(:income_history_2) { FactoryGirl.create(:income_history, partner: partner, referral: user, created_at: 1.month.ago) }
        let!(:income_history_3) { FactoryGirl.create(:income_history, partner: partner, referral: user) }

        context "when date_from provided" do
          it "returns proper data" do
            results = Referrals::IncomeHistory.by_date_from(1.month.ago).map(&:id)

            expect(results).to eq([income_history_2.id, income_history_3.id])
          end
        end

        context "when date_from not provided" do
          it "returns all data" do
            results = Referrals::IncomeHistory.by_date_from(nil).map(&:id)

            expect(results).to eq([income_history_1.id, income_history_2.id, income_history_3.id])
          end
        end
      end

      describe ".date_to" do

      end

    end

  end
end
