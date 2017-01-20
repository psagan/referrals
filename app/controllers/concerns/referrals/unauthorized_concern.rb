module Referrals
  module UnauthorizedConcern

    private

    def unauthorized_unless_admin
      raise ::Referrals::UnauthorizedError, 'Unauthorized user in admin area!' unless current_user.admin?
    end

    def unauthorized_unless_partner
      raise ::Referrals::UnauthorizedError, 'User is not a partner!' unless current_user.partner?
    end
  end
end