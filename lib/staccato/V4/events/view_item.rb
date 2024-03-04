module Staccato::V4
  class ViewItem
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
