module Referrals
  class WithdrawalController < ApplicationController
    include ::Referrals::FilterConcern
    include ::Referrals::UnauthorizedConcern
    include ::Referrals::LayoutConcern

    before_action :unauthorized_unless_partner
    before_action :set_partner, only: [:index, :new, :create]
    before_action :set_filter_data, only: [:index, :filter]

    def index
      @withdrawals = ::Referrals::Withdrawal
        .by_partner(@partner)
        .by_date_from(filter_data.date_from)
        .by_date_to(filter_data.date_to)
        .page(filter_data.page)
        .order('created_at DESC')
    end

    def new
      @withdrawal = ::Referrals::Withdrawal.new
    end

    def create
      if create_service.call
        redirect_to action: :index
      else
        @withdrawal = create_service.withdrawal
        render action: :new
      end
    end

    def filter
      redirect_to withdrawal_index_path(filter_data.to_h)
    end

    private

    def set_partner
      @partner = current_user.partner
    end

    def withdrawal_params
      params.require(:withdrawal).permit(:amount)
    end

    def create_service
      @create_service ||= ::Referrals::CreateWithdrawalService.new(amount: withdrawal_params[:amount], partner: @partner)
    end

  end
end