class CreateReferralsWithdrawalHistories < ActiveRecord::Migration
  def change
    create_table :referrals_withdrawal_histories do |t|
      t.integer :withdrawal_id, null: false, index: true
      t.integer :status_from
      t.integer :status_to

      t.timestamps
    end
  end
end
