module Staccato::V4
  class ViewItem
    FIELDS = [
      :currency,
      :value,
      :session_id,
      :items
    ]

    include Event
  end
end
