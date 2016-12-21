class User < ApplicationRecord
  include Referrals::Referable
end