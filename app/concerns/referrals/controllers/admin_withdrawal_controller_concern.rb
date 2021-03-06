module Referrals
  module Controllers
    module AdminWithdrawalControllerConcern
      extend ActiveSupport::Concern

      included do
        include ::Referrals::UnauthorizedConcern
        include ::Referrals::FilterConcern

        before_action :set_withdrawal, only: [:show, :update]
        before_action :set_filter_data
        before_action :unauthorized_unless_admin

        layout Referrals.admin_layout if Referrals.admin_layout
      end

      def index
        @withdrawals = ::Referrals::Withdrawal
                         .by_date_from(filter_data.date_from)
                         .by_date_to(filter_data.date_to)
                         .by_status(filter_data.status)
                         .page(filter_data.page)
                         .order(created_at: :desc)
      end

      def update
        ::Referrals::UpdateWithdrawalService.new(
          withdrawal: @withdrawal,
          status: withdrawal_params[:status]
        ).call
        filter
      end

      def filter
        redirect_to admin_withdrawal_index_path(filter_data.to_h)
      end

      def show
      end

      private

      def withdrawal_params
        params.require(:withdrawal).permit(:status)
      end

      def set_withdrawal
        @withdrawal = ::Referrals::Withdrawal.find(params[:id])
      end

    end
  end
end
