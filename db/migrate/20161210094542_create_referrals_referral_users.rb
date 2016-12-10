class CreateReferralsReferralUsers < ActiveRecord::Migration
  def change
    create_table :referrals_referral_users do |t|
      t.integer :user_id, null: false, index: true, unique: true
      t.references :partner, foreign_key: true, null: false

      t.timestamps
    end
  end
end
