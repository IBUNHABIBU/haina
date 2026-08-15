FactoryBot.define do
  factory :activity do
    customer { "MyString" }
    phone { "MyString" }
    TV_brand { "MyString" }
    TV_size { 1 }
    model_no { "MyString" }
    date_in { "2026-08-15 09:02:19" }
    date_out { "2026-08-15 09:02:19" }
    starting_price { "9.99" }
    final_price { "9.99" }
    status { 1 }
    spare_used { 1 }
    cost_each { "9.99" }
    total_cost { "9.99" }
    profit { "9.99" }
    remarks { "MyText" }
    labour_cost { "9.99" }
    user { nil }
  end
end
