require 'rails_helper'
require 'support/shared/monetize_attr'

module Referrals
  RSpec.describe Partner, type: :model do
    describe "#amount" do
      include_examples :monetize_attr, :amount
    end
  end
end