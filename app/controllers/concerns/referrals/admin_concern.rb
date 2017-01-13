module Referrals
  module AdminConcern
    private

    def admin?
      Referrals.admin_callback.call
    end

    def redirect_to_root_unless_admin
      redirect_to root_url unless admin?
    end
  end
end