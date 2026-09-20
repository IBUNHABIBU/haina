FactoryBot.define do
  factory :repair_job do
    customer { nil }
    tv_brand { nil }
    tv_size { nil }
    labour_price { "9.99" }
    total_sale { "9.99" }
    status { 1 }
    tatizo { "MyString" }
    reference { "MyString" }
    motherboard_number { "MyString" }
    tcon_number { "MyString" }
    panel_number { "MyString" }
    cof_number { "MyString" }
  end
end
