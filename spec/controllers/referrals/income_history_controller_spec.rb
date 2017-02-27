require 'rails_helper'

RSpec.describe ::Referrals::IncomeHistoryController, type: :controller do

  # http://bit.ly/2jatysA
  routes { Referrals::Engine.routes }

  3.times do |n|
    i = n+1
    let!("partner_user_#{i}") { FactoryGirl.create(:user) }
    let!("partner_#{i}") { FactoryGirl.create(:partner, user: send("partner_user_#{i}")) }
    let!("user_#{i}") { FactoryGirl.create(:user) }
    let!("income_histories_#{i}") { FactoryGirl.create_list('income_history', 5, referral: send("user_#{i}"), partner: send("partner_#{i}")) }
  end

  ::Referrals::IncomeHistoryController.class_eval do
    def current_user
      User.first
    end
  end

  describe "GET index" do

    # [SECURITY CHECK]
    it "assigns income histories for specific partner only" do
      get :index

      expect(assigns(:income_histories)).to eq(partner_1.income_histories.order('created_at DESC'))
    end
  end

end