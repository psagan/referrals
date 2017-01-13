require 'rails_helper'
require 'support/shared/monetize_attr'
require 'support/shared/filterable'

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

            it "adds error" do
              subject.valid?

              expected = [{error: :greater_thant_available_funds, count: partner.amount}]
              expect(subject.errors.details[:amount]).to eq(expected)
            end
          end

          context "amount less than required value for withdrawal" do
            let(:amount) { 10 }

            it "returns false" do
              expect(subject.valid?).to eq(false)
            end

            it "adds error" do
              subject.valid?

              expected = [{error: :less_than_min_withdrawal_amount, count: Money.new(min_withdrawal_amount)}]
              expect(subject.errors.details[:amount]).to eq(expected)
            end
          end
        end
      end
    end

    describe "#status_number" do
      context "when parameter provided" do
        context "when valid status provided" do
          it "returns proper status number" do
            described_class.statuses.each do |k,v|
              expect(described_class.new.status_number(k)).to eq(v)
            end
          end
        end

        context "when invalid status provided" do
          it "returns nil" do
            expect(described_class.new.status_number('unknown')).to eq(nil)
          end
        end
      end

      context "when no parameter provided" do
        it "returns current status number" do
          described_class.statuses.each do |k,v|
            subject = described_class.new(status: k)

            expect(subject.status_number).to eq(v)
          end
        end
      end
    end

    describe "#amount" do
      include_examples :monetize_attr, :amount
    end

    describe "filterable scopes" do
      include_examples :filterable, :withdrawal

      describe ".by_status" do
        subject { described_class }
        let!(:withdrawal_pending) { FactoryGirl.create_list(:withdrawal, 2, status: :pending)}
        let!(:withdrawal_paid) { FactoryGirl.create_list(:withdrawal, 2, status: :paid)}
        let!(:withdrawal_cancelled) { FactoryGirl.create_list(:withdrawal, 2, status: :cancelled)}

        context "when proper status provided" do
          it "returns pending" do
            result = subject.by_status('pending')

            expect(result).to eq(withdrawal_pending)
          end

          it "returns paid" do
            result = subject.by_status('paid')

            expect(result).to eq(withdrawal_paid)
          end

          it "returns cancelled" do
            result = subject.by_status('cancelled')

            expect(result).to eq(withdrawal_cancelled)
          end
        end

        context "when improper status provided" do
          context "when blank status" do
            it "returns all" do
              result = subject.by_status(nil)

              expect(result).to eq(withdrawal_pending + withdrawal_paid + withdrawal_cancelled)
            end
          end

          context "when non existing status" do
            it "returns nothing" do
              result = subject.by_status('non_existing_status')

              expect(result).to eq([])
            end
          end
        end
      end
    end

  end
end
