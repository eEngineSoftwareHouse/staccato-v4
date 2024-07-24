module Staccato::V4
  class Refund
    FIELDS = [
      :currency,
      :transaction_id,
      :value,
      :affiliation,
      :coupon,
      :shipping,
      :tax,
      :session_id,
      :debug_mode,
      :items
    ]

    include Event
  end
end
