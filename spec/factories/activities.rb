FactoryBot.define do
  factory :activity do
    customer { "MyString" }
    phone { "MyString" }
    TV_brand { "MyString" }
    TV_size { 1 }
    model_no { 1 }
    date_in { "2026-08-15 08:23:37" }
    date_out { "2026-08-15 08:23:37" }
    starting_price { "9.99" }
    final_price { "9.99" }
    status { 1 }
    spare_used { 1 }
    cost_each { "9.99" }
    total_cost { "9.99" }
    profit { "9.99" }
    remarks { "MyText" }
    user { nil }
  end
end
