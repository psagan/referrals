require "referrals/engine"

module Referrals
  # Your code goes here...
  mattr_accessor :user_class, :default_share, :min_withdrawal_amount, :current_user_callback, :admin_callback
end
