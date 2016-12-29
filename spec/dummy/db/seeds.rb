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
      partner.reload.partnership.referrals << u
      Referrals::IncomeHistory.create(
          referral: u,
          partner: partner.partnership,
          info: 'Payment for subscription',
          amount_cents: 2077,
          share: partner.partnership.share,
          share_amount_cents: partner.partnership.share * 2077,
          created_at: created_at
      )
    end
  end
end



