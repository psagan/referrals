module Referrals
  module WithdrawalHelper
    def withdrawal_status_by_number(number)
      t("activerecord.attributes.referrals/withdrawal.status.#{::Referrals::Withdrawal.statuses.key(number)}")
    end
  end
end