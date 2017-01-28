module Referrals
  class AdminWithdrawalController < ApplicationController
    include ::Referrals::Concerns::Controllers::AdminWithdrawalControllerConcern
  end
end