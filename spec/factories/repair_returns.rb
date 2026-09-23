FactoryBot.define do
  factory :repair_return do
    activity
    returned_at { Time.current }
    location { "Workshop" }
    reason { "Returned with same fault" }
    condition { "Customer returned TV" }
    status { "received" }
  end
end
