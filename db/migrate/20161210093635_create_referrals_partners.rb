class CreateReferralsPartners < ActiveRecord::Migration
  def change
    create_table :referrals_partners do |t|
      t.integer :amount, null: false, default: 0
      t.decimal :share, null: false, default: Referrals.default_share || 0.0, precision: 5, scale: 2
      t.integer :user_id, null: false, index: true

      t.timestamps
    end
  end
end
