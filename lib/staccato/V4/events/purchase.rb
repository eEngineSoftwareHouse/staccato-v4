module Staccato::V4
  class Purchase
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
