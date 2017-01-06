require 'rails_helper'

module Referrals
  RSpec.describe Withdrawal, type: :model do

    let(:partner) { FactoryGirl.create(:partner, amount: 100) }
    let(:amount) { 90 }
    let(:data) do
      {
          partner: partner,
          amount: amount
      }
    end
    let(:min_withdrawal_amount) { 5000 }
    before do
      Referrals.min_withdrawal_amount = min_withdrawal_amount
    end
    subject { described_class.new(data) }

    describe "#valid?" do
      context "when all data are valid" do

        it "returns true" do
          expect(subject.valid?).to eq(true)
        end
      end

      context "when data are invalid" do
        context "amount is invalid" do
          context "amount greater that available funds" do
            let(:amount) { 101 }

            it "returns false" do
              expect(subject.valid?).to eq(false)
            end

            # shared ex
            it "adds error" do
              subject.valid?

              expect(subject.errors.details[:amount]).to eq([{error: :greater_thant_available_funds, count: partner.amount}])
            end
          end

          context "amount less than required value for withdrawal" do
            let(:amount) { 10 }

            it "returns false" do
              expect(subject.valid?).to eq(false)
            end

            # shared ex
            it "adds error" do
              subject.valid?

              expected = [{error: :less_than_min_withdrawal_amount, count: Money.new(min_withdrawal_amount)}]
              expect(subject.errors.details[:amount]).to eq(expected)
            end
          end
        end
      end
    end

  end
end
