module Staccato::V4
  class AddShippingInfo
    FIELDS = [
      :currency,
      :value,
      :coupon,
      :shipping_tier,
      :session_id,
      :debug_mode,
      :items
    ]

    include Event
  end
end
