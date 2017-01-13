Referrals.user_class = "User"
Referrals.default_share = 0.5
Referrals.min_withdrawal_amount = 10000
Referrals.current_user_callback = -> { User.first }
Referrals.admin_callback = -> { User.first.admin? }
