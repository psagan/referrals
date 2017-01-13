require 'rails_helper'

RSpec.describe Referrals::UpdateWithdrawalService do
  before do
    Referrals.min_withdrawal_amount = 10
  end

  shared_examples :does_not_change_partner_amount do
    it "does not change partner amount" do
      expect { service.call }.to change { partner.amount }.by(0)
      expect(partner.reload.amount).to eq(Money.new(70847))
    end
  end

  shared_examples :add_history do
    it "add history" do
      expect { service.call }.to change { withdrawal.withdrawal_histories.count }.by(1)
    end
  end

  shared_examples :does_not_change_anything do
    it "does not change status" do
      expect(withdrawal.pending?).to eq(true)

      service.call

      expect(withdrawal.pending?).to eq(true)
    end

    it "does not add history" do
      expect { service.call }.to change { withdrawal.withdrawal_histories.count }.by(0)
    end

    include_examples :does_not_change_partner_amount
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

        include_examples :add_history

        context "when previous status pending" do
          include_examples :does_not_change_partner_amount
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

        include_examples :add_history

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

        include_examples :add_history

        context "when previous status paid" do
          include_examples :does_not_change_partner_amount
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
        include_examples :does_not_change_anything
      end

      context "when same status provided" do
        let(:status) { 'pending' }

        include_examples :does_not_change_anything
      end
    end
  end
end