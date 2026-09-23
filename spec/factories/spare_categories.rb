FactoryBot.define do
  factory :spare_category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:code) { |n| "CAT#{n}" }
  end
end
