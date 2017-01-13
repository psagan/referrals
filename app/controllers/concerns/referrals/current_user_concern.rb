module Referrals
  module CurrentUserConcern
    private

    def current_user
      Referrals.current_user_callback.call
    end
  end
end