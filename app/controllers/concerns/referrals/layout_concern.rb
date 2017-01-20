module Referrals
  module LayoutConcern
    extend ActiveSupport::Concern

    included do
      layout Referrals.layout if Referrals.layout
    end
  end
end