FactoryBot.define do
  factory :spare_request do
    activity { nil }
    spare { nil }
    requested_by { nil }
    issued_by { nil }
    requested_quantity { 1 }
    issued_quantity { 1 }
    unit_cost_at_issue { "9.99" }
    status { "MyString" }
    reason { "MyText" }
    store_notes { "MyText" }
    issued_at { "2026-10-12 17:31:59" }
  end
end
