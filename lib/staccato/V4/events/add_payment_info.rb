module Staccato::V4
  class AddPaymentInfo
    FIELDS = [
      :currency,
      :value,
      :coupon,
      :payment_type,
      :session_id,
      :debug_mode,
      :items
    ]
    
    include Event
  end
end
