FactoryBot.define do
  factory :activity do
    user
    customer
    tv_brand
    tv_size
    tatizo
    phone { customer.phone }
    model_no { "UA55TEST" }
    date_in { Time.current }
    status { :received }
    price { 150_000 }
    labour_charge { 50_000 }
    remarks { "Test repair" }
  end
end
