# create users
q = 10
2.times do |i|
  email = "partner#{i}@example.com"
  User.create(email: email)
  partner_user = User.find_by_email(email).tap {|u| u.make_partner!}
  q.times do |n|
    User.create(email: "m#{i}_#{n}@example.com")
    User.last.tap do |u|
      partner_user.reload.partner.referrals << u
      Referrals::CaptureReferralActionService.new(amount: Money.new(20077), referral: u, info: 'Payment for subscription').call
    end
  end
  # change date in half
  partner_user.partner.income_histories.take(q/2).each { |income_history| income_history.update(created_at: 35.days.ago) }

  # add withdrawals
  4.times do
    ::Referrals::CreateWithdrawalService.new(amount: 101.47, partner: partner_user.partner).call
  end
  partner_user.partner.withdrawals.take(2).each { |withdrawal| withdrawal.update(created_at: 34.days.ago) }
  # differentiate some statuses
  partner_user.partner.withdrawals.first.cancelled!
  partner_user.partner.withdrawals.last.paid!
end



