require 'rails_helper'
require 'support/shared/monetize_attr'

module Referrals
  RSpec.describe Partner, type: :model do
    describe "#amount" do
      include_examples :monetize_attr, :amount
    end

    subject(:partner) { FactoryGirl.build(:partner, amount: 100.10) }

    shared_examples :changes_amount do |method, expected_cents|
      it "changes amount" do
        partner.send(method, Money.new(2041))

        expect(partner.amount).to eq(Money.new(expected_cents))
      end
    end

    describe "#increase_amount" do
      include_examples :changes_amount, :increase_amount, 12051
    end

    describe "#decrease_amount" do
      include_examples :changes_amount, :decrease_amount, 7969
    end
  end
end