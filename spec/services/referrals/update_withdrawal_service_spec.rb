require 'rails_helper'

RSpec.describe Referrals::UpdateWithdrawalService do
  before do
    Referrals.min_withdrawal_amount = 10
  end

  describe "#call" do
    let(:partner) { FactoryGirl.create(:partner, amount: 708.47) }
    let(:withdrawal) { FactoryGirl.create(:withdrawal, status: :pending) }
    subject(:service) { described_class.new(withdrawal: withdrawal, status: status) }
    context "when proper status provided" do
      context "when status paid" do
        let(:status) { 'paid' }
        it "set paid status" do
          service.call

          expect(withdrawal.reload.paid?).to eq(true)
        end

        context "when previous status pending" do
          it "does not change partner amount" do

          end
        end

        context "when previous status cancelled" do
          it "decreases partner amount" do

          end
        end
      end

      context "when status cancelled" do
        let(:status) { 'cancelled' }
        it "set cancelled status" do
          service.call

          expect(withdrawal.reload.cancelled?).to eq(true)
        end

        it "increases partner amount" do

        end
      end

      context "when status pending" do
        let(:status) { 'pending' }
        before do
          withdrawal.paid!
        end
        it "set pending status" do
          service.call

          expect(withdrawal.reload.pending?).to eq(true)
        end
      end

      context "when previous status paid" do
        it "does not change partner amount" do

        end
      end

      context "when previous status cancelled" do
        it "decreases partner amount" do

        end
      end
    end

    context "when improper status provided" do
      let(:status) { 'not_existing_status' }
      it "does not change status" do
        expect(withdrawal.pending?).to eq(true)

        service.call

        expect(withdrawal.pending?).to eq(true)
      end

      it "does not change partner amount" do

      end
    end
  end
end