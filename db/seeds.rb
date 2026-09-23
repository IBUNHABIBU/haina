# Idempotent seed data for the repair-management module.
puts "************   Start seeding  *****************"
[
  ["COF", "COF"],
  ["T-Con", "TCON"],
  ["Main Board", "MAIN"],
  ["Power Supply", "PSU"],
  ["Backlight", "BACKLIGHT"],
  ["Panel", "PANEL"],
  ["Other", "OTHER"]
].each do |name, code|
  SpareCategory.find_or_create_by!(code: code) { |category| category.name = name }
end

[
  "No Power", "No Display", "No Backlight", "Lines on Screen", "Half Screen",
  "No Signal", "Dead Panel", "Software Problem", "HDMI Problem", "Other"
].each { |name| Tatizo.find_or_create_by!(name: name) }

[
  "Samsung", "LG", "Hisense", "TCL", "Aboarder", "Alitop", "Singsung", "Sony"
].each { |name| TvBrand.find_or_create_by!(name: name) }

[24, 32, 40, 43, 48, 50, 55, 58, 65, 70, 75, 85, 98, 100].each do |size|
  TvSize.find_or_create_by!(size: size)
end

puts "********************  End seeding   *************************"
