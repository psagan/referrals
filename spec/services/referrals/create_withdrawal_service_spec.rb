require 'rails_helper'

RSpec.describe Referrals::CreateWithdrawalService do

  let(:amount) { 50.45 }
  let(:partner) { FactoryGirl.create(:partner, amount: 100.10) }
  subject(:service) { described_class.new(partner: partner, amount: amount) }

  describe "#call" do
    before do
      Referrals.min_withdrawal_amount = nil
    end
    context "when withdrawal has no errors" do

      it "returns true" do
        expect(service.call).to eq(true)
      end

      it "creates withdrawal" do
        expect { service.call }.to change { ::Referrals::Withdrawal.where(partner: partner).count }.by(1)
      end

      it "creates withdrawal history" do
        expect { service.call }.to change { ::Referrals::WithdrawalHistory.where(withdrawal: service.withdrawal).count }.by(1)
        withdrawal_history = service.withdrawal.withdrawal_histories.first
        expect(withdrawal_history.status_from).to eq(nil)
        expect(withdrawal_history.status_to).to eq(service.withdrawal.status_number)
      end

      it "decreases partner amount" do
        service.call

        expect(partner.reload.amount).to eq(Money.new(4965))
      end
    end

    context "when withdrawal has errors" do

      before do
        allow_any_instance_of(::Referrals::Withdrawal).to receive(:save).and_return(false)
      end

      it "returns false" do
        expect(service.call).to eq(false)
      end

      it "does not create withdrawal" do
        expect { service.call }.to change { ::Referrals::Withdrawal.where(partner: partner).count }.by(0)
      end

      it "creates withdrawal history" do
        expect { service.call }.to change { ::Referrals::WithdrawalHistory.where(withdrawal: service.withdrawal).count }.by(0)
      end

      it "does not update partner amount" do
        expect(partner.reload.amount).to eq(Money.new(10010))
      end
    end
  end

end