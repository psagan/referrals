require 'rails_helper'

RSpec.describe Referrals::UpdateWithdrawalService do
  before do
    Referrals.min_withdrawal_amount = 10
  end

  describe "#call" do
    let(:partner) { FactoryGirl.create(:partner, amount: 708.47) }
    let(:withdrawal) { FactoryGirl.create(:withdrawal, status: previous_status, amount: 127.38, partner: partner) }
    subject(:service) { described_class.new(withdrawal: withdrawal, status: status) }
    let(:previous_status) { 'pending' }
    context "when proper status provided" do
      context "when new status paid" do
        let(:status) { 'paid' }
        it "set paid status" do
          service.call

          expect(withdrawal.reload.paid?).to eq(true)
        end

        context "when previous status pending" do
          it "does not change partner amount" do
            expect { service.call }.to change { partner.amount }.by(0)
            expect(partner.reload.amount).to eq(Money.new(70847))
          end
        end

        context "when previous status cancelled" do
          let(:previous_status) { 'cancelled' }
          it "decreases partner amount" do
            service.call

            expect(partner.reload.amount).to eq(Money.new(58109))
          end
        end
      end

      context "when new status cancelled" do
        let(:status) { 'cancelled' }
        it "set cancelled status" do
          service.call

          expect(withdrawal.reload.cancelled?).to eq(true)
        end

        context "when previous status pending" do
          it "increases partner amount" do
            service.call

            expect(partner.reload.amount).to eq(Money.new(83585))
          end
        end

        context "when previous status paid" do
          let(:previous_status) { 'paid' }
          it "increases partner amount" do
            service.call

            expect(partner.reload.amount).to eq(Money.new(83585))
          end
        end
      end

      context "when new status pending" do
        let(:status) { 'pending' }
        let(:previous_status) { 'paid' }
        it "set pending status" do
          service.call

          expect(withdrawal.reload.pending?).to eq(true)
        end

        context "when previous status paid" do
          it "does not change partner amount" do
            service.call

            expect { service.call }.to change { partner.amount }.by(0)
            expect(partner.reload.amount).to eq(Money.new(70847))
          end
        end

        context "when previous status cancelled" do
          let(:previous_status) { 'cancelled' }
          it "decreases partner amount" do
            p withdrawal.cancelled?
            service.call

            expect(partner.reload.amount).to eq(Money.new(58109))
          end
        end
      end
    end

    context "when improper status provided" do
      context "when unknown status" do
        let(:status) { 'not_existing_status' }
        it "does not change status" do
          expect(withdrawal.pending?).to eq(true)

          service.call

          expect(withdrawal.pending?).to eq(true)
        end

        it "does not change partner amount" do
          expect { service.call }.to change { partner.amount }.by(0)
          expect(partner.reload.amount).to eq(Money.new(70847))
        end
      end

      context "when same status provided" do
        let(:status) { 'pending' }

        it "does not change status" do
          expect(withdrawal.pending?).to eq(true)

          service.call

          expect(withdrawal.pending?).to eq(true)
        end

        it "does not change partner amount" do
          expect { service.call }.to change { partner.amount }.by(0)
          expect(partner.reload.amount).to eq(Money.new(70847))
        end
      end
    end
  end
end