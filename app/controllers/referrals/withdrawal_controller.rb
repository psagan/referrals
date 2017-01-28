module Referrals
  class WithdrawalController < ApplicationController
    include ::Referrals::Controllers::WithdrawalControllerConcern
  end
end