class CreateReferralsWithdrawals < ActiveRecord::Migration
  def change
    create_table :referrals_withdrawals do |t|
      t.integer :partner_id, null: false, index: true
      t.integer :amount_cents, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
