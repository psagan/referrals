require "referrals/engine"

module Referrals
  # Your code goes here...
  mattr_accessor :user_class, :default_share, :min_withdrawal_amount,
                 :layout, :admin_layout

  # very simple event hooks
  module Events
    def self.after_withdrawal_create
      -> (context) {}
    end
  end
end
