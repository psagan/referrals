module Referrals
  module AdminConcern

    private

    def unauthorized_unless_admin
      raise ::Referrals::UnauthorizedError, 'Unauthorized user in admin area!' unless current_user.admin?
    end
  end
end