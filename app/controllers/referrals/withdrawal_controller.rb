module Referrals
  class WithdrawalController < ApplicationController
    include ::Referrals::Concerns::Controllers::WithdrawalControllerConcern
  end
end