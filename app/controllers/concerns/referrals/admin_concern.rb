module Referrals
  module AdminConcern
    private

    def unauthorized_unless_admin
      redirect_to root_url unless current_user.admin?
    end
  end
end