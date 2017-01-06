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
      let!(:income_history_1) { FactoryGirl.create(:income_history, partner: partner, referral: user, created_at: 2.months.ago) }
      let!(:income_history_2) { FactoryGirl.create(:income_history, partner: partner, referral: user, created_at: 1.month.ago) }
      let!(:income_history_3) { FactoryGirl.create(:income_history, partner: partner, referral: user) }
      let(:date) { 1.month.ago }

      describe ".by_date_from" do
        context "when date_from provided" do
          it "returns proper data by date_from" do
            results = Referrals::IncomeHistory.by_date_from(1.month.ago)

            expect(results).to eq([income_history_2, income_history_3])
          end
        end

        context "when date_from not provided" do
          it "returns all data" do
            results = Referrals::IncomeHistory.by_date_from(nil)

            expect(results).to eq([income_history_1, income_history_2, income_history_3])
          end
        end
      end

      describe ".by_date_to" do
        context "when date_to provided" do
          it "returns proper data by date_to" do
            results = Referrals::IncomeHistory.by_date_to(1.month.ago)

            expect(results).to eq([income_history_1, income_history_2])
          end
        end

        context "when date_to not provided" do
          it "returns all data" do
            results = Referrals::IncomeHistory.by_date_from(nil)

            expect(results).to eq([income_history_1, income_history_2, income_history_3])
          end
        end
      end

      describe ".by_partner" do
        let!(:partner_user_2) { FactoryGirl.create(:user) }
        let!(:partner_2) { FactoryGirl.create(:partner, user: partner_user_2) }
        let!(:income_history_1) { FactoryGirl.create(:income_history, partner: partner, referral: user) }
        let!(:income_history_2) { FactoryGirl.create(:income_history, partner: partner_2, referral: user) }
        let!(:income_history_3) { FactoryGirl.create(:income_history, partner: partner, referral: user) }

        it "returns data for partner" do
          result = Referrals::IncomeHistory.by_partner(partner)

          expect(result).to eq([income_history_1, income_history_3])
        end
      end

    end

  end
end
