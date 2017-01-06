# create users
q = 10
2.times do |i|
  email = "partner#{i}@example.com"
  User.create(email: email)
  partner = User.find_by_email(email).tap {|u| u.make_partner!}
  q.times do |n|
    created_at = n < (q/2) ? 1.month.ago : DateTime.now
    User.create(email: "m#{i}_#{n}@example.com")
    User.last.tap do |u|
      partner.reload.partner.referrals << u
      Referrals::CaptureReferralActionService.new(amount: Money.new(2077), referral: u, info: 'Payment for subscription').call
    end
  end
end



