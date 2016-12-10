class CreateReferralsPartners < ActiveRecord::Migration
  def change
    create_table :referrals_partners do |t|
      t.integer :amount, null: false, default: 0
      t.decimal :share, null: false, default: 0.0
      t.integer :user_id, null: false, index: true

      t.timestamps
    end
  end
end
