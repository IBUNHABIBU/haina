FactoryBot.define do
  factory :spare do
    spare_category
    sequence(:name) { |n| "Spare #{n}" }
    unit_cost { 20_000 }
    selling_price { 30_000 }
    quantity { 10 }
    reorder_level { 2 }
  end
end
