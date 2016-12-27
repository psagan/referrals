# create users
User.create(email: 'partner@example.com')
partner = User.first
4.times do |n|
  User.create(email: "m#{n}@example.com")
  User.last.tap do |u|
    partner.reload.partnership.referrals << u
    Referrals::IncomeHistory.create(
        referral: u,
        partner: partner.partnership,
        info: 'Payment for subscription',
        amount: 2077,
        share: partner.partnership.share,
        share_amount: partner.partnership.share * 2077
    )
  end
end



