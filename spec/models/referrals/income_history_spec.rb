require 'rails_helper'
require 'support/shared/monetize_attr'
require 'support/shared/filterable'

module Referrals
  RSpec.describe IncomeHistory, type: :model do

    describe "#amount" do
      include_examples :monetize_attr, :amount
    end

    describe "#share_amount" do
      include_examples :monetize_attr, :share_amount
    end

    describe "filterable scopes" do
      include_examples :filterable, :income_history
    end

  end
end
