module Staccato::V4
  class ViewItemList
    FIELDS = [
      :item_list_id,
      :item_list_name,
      :session_id,
      :items
    ]

    include Event
  end
end
