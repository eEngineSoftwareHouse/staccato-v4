module Staccato::V4
  class BeginCheckout
    FIELDS = [
      :currency,
      :value,
      :coupon,
      :session_id,
      :debug_mode,
      :items
    ]

    include Event
  end
end
