50.times do |i|
  customer = Customer.create!(
    name:  "Customer #{i + 1}",
    phone: "07#{rand(10**8).to_s.rjust(8, '0')}",
    email: "customer#{i + 1}@example.com"
  )
end