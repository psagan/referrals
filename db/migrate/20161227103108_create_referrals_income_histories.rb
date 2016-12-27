class CreateReferralsIncomeHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :referrals_income_histories do |t|
      t.partner :association
      t.integer :user_id, null: false, index: true
      t.string :info
      t.integer :amount, null: false, default: 0
      t.decimal :share, null: false, precision: 5, scale: 2, default: 0.0
      t.integer :share_amount, null: false, default: 0

      t.timestamps
    end
  end
end
