FactoryBot.define do
  factory :return do
    repair_job { nil }
    reason { "MyString" }
    remarks { "MyText" }
  end
end
