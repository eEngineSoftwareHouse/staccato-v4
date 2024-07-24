module Staccato::V4
  class RemoveFromCart
    FIELDS = [
      :currency,
      :value,
      :session_id,
      :debug_mode,
      :items
    ]

    include Event
  end
end
