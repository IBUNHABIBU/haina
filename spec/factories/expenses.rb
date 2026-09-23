FactoryBot.define do
  factory :expense do
    user
    category { "electricity" }
    description { "Test electricity" }
    amount { 25_000 }
    spent_on { Date.current }
  end
end
