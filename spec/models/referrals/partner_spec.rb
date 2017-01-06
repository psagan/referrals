require 'rails_helper'
require 'support/shared/monetize_attr'

module Referrals
  RSpec.describe Partner, type: :model do
    describe "#amount" do
      include_examples :monetize_attr, :amount
    end

    subject(:partner) { FactoryGirl.build(:partner, amount: 100.10) }

    describe "#increase_amount" do
      it "increases amount" do
        partner.increase_amount(Money.new(2041))

        expect(partner.amount).to eq(Money.new(12051))
      end
    end

    describe "#decrease_amount" do
      it "decreases amount" do
        partner.decrease_amount(Money.new(2041))

        expect(partner.amount).to eq(Money.new(7969))
      end
    end
  end
end