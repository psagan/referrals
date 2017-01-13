class User < ApplicationRecord
  include Referrals::Referable

  def admin?
    true
  end
end