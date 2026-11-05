# Idempotent seed data for the repair-management module.
# ============================================================
# 0. User (admin)
# ============================================================
puts "👤 Creating admin user..."
admin = User.find_or_create_by!(email: "admin@tour.com") do |u|
  u.password = "123"
  u.password_confirmation = "123"
  u.first_name = "Admin"
  u.last_name = "Tour"
  u.confirmed_at = Time.current
end

puts "  ✅ Admin user: #{admin.email}"

# ============================================================
# 2. Customers
# ============================================================
puts "👥 Creating customers..."
customers = [
  { name: "John Mwangi", phone: "0712 345 678", mahali: "Kariakoo" },
  { name: "Amina Hassan", phone: "0765 432 109", mahali: "Kinondoni" },
  { name: "Peter Kimaro", phone: "0789 123 456", mahali: "Mikocheni" },
  { name: "Grace Mushi", phone: "0754 987 654", mahali: "Sinza" },
  { name: "David Mwakalinga", phone: "0713 456 789", mahali: "Tabata" },
  { name: "Fatuma Salum", phone: "0768 234 567", mahali: "Magomeni" },
  { name: "Joseph Mwakyusa", phone: "0745 678 901", mahali: "Ubungo" },
  { name: "Rehema Msuya", phone: "0719 012 345", mahali: "Ilala" },
  { name: "Michael Mbwana", phone: "0782 345 678", mahali: "Mbezi" },
  { name: "Zainabu Juma", phone: "0756 789 012", mahali: "Mwananyamala" },
].map { |attrs| Customer.create!(attrs.merge(user: admin)) }

puts "  ✅ #{customers.size} customers created"

puts "************   Start seeding  *****************"
[
  [ "COF", "COF" ],
  [ "T-Con", "TCON" ],
  [ "Main Board", "MAIN" ],
  [ "Power Supply", "PSU" ],
  [ "Backlight", "BACKLIGHT" ],
  [ "Panel", "PANEL" ],
  [ "Other", "OTHER" ]
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

[ 24, 32, 40, 43, 48, 50, 55, 58, 65, 70, 75, 85, 98, 100 ].each do |size|
  TvSize.find_or_create_by!(size: size)
end

puts "********************  End seeding   *************************"


# db/seeds.rb

category = SpareCategory.find_or_initialize_by(name: "tek")
category.code = "TEK" if category.code.blank?
category.save!

spares_data = [
  ["svg", "TAPE9312-01-1A", 2500, 4],
  ["LED Backlight", "LB-001", 12000, 8],
  ["Power Supply Board", "PSU-002", 35000, 3],
  ["Main Board", "MB-003", 45000, 5],
  ["T-Con Board", "TC-004", 18000, 6],
  ["HDMI Port", "HDMI-005", 1500, 20],
  ["USB Port", "USB-006", 1000, 15],
  ["DC Jack", "DC-007", 2000, 10],
  ["Capacitor 1000uF", "CAP-008", 500, 30],
  ["Capacitor 470uF", "CAP-009", 400, 25],
  ["MOSFET", "MOS-010", 2500, 12],
  ["Rectifier Diode", "DIO-011", 800, 18],
  ["Fuse 3A", "FUS-012", 300, 40],
  ["Optocoupler", "OPTO-013", 1200, 14],
  ["PWM IC", "PWM-014", 1800, 9],
  ["EEPROM IC", "EEP-015", 1500, 11],
  ["Voltage Regulator", "REG-016", 1000, 16],
  ["Audio IC", "AUD-017", 3500, 7],
  ["LVDS Cable", "LVD-018", 5000, 5],
  ["Speaker 8 Ohm", "SPK-019", 4000, 8],
  ["IR Sensor Board", "IR-020", 3000, 6],
  ["Remote Sensor", "RS-021", 1800, 10],
  ["T-Con Fuse", "TCF-022", 500, 20],
  ["Backlight Connector", "BLC-023", 700, 18],
  ["Resistor 10K", "RES-024", 100, 100],
  ["Ceramic Capacitor", "CC-025", 150, 80],
  ["Inductor Coil", "IND-026", 1200, 10],
  ["Bridge Rectifier", "BR-027", 1800, 12],
  ["Transformer", "TR-028", 8500, 3],
  ["AC Power Cable", "AC-029", 2500, 12],
  ["Panel Connector", "PC-030", 2200, 7],
  ["COF Tape", "COF-031", 6000, 4],
  ["Thermal Paste", "TP-032", 3500, 9],
  ["SMD LED", "LED-033", 250, 50],
  ["Zener Diode", "ZD-034", 300, 40],
  ["Transistor", "TRN-035", 600, 25],
  ["Crystal Oscillator", "XTAL-036", 900, 15],
  ["Ethernet Port", "ETH-037", 2500, 8],
  ["Wi-Fi Module", "WIFI-038", 7500, 4],
  ["Panel Ribbon Cable", "PRC-039", 3000, 6]
]

spares_data.each do |name, part_number, unit_cost, quantity|
  spare = Spare.find_or_initialize_by(name: name)

  spare.assign_attributes(
    spare_category: category,
    part_number: part_number,
    unit_cost: unit_cost,
    selling_price: (unit_cost * 1.3).round(2),
    quantity: quantity,
    reorder_level: 3
  )

  spare.save!
end

puts "Created/updated #{spares_data.size} test spares."

# db/seeds.rb

puts "🌱 Seeding data..."

# ============================================================
# 1. Futa data ya zamani (kwa usalama)
# ============================================================
puts "🧹 Cleaning old data..."
Activity.destroy_all
Customer.destroy_all
Spare.destroy_all
SpareCategory.destroy_all
Expense.destroy_all

# ============================================================
# 2. Customers
# ============================================================
puts "👥 Creating customers..."
customers = [
  { name: "John Mwangi", phone: "0712 345 678", mahali: "Kariakoo" },
  { name: "Amina Hassan", phone: "0765 432 109", mahali: "Kinondoni" },
  { name: "Peter Kimaro", phone: "0789 123 456", mahali: "Mikocheni" },
  { name: "Grace Mushi", phone: "0754 987 654", mahali: "Sinza" },
  { name: "David Mwakalinga", phone: "0713 456 789", mahali: "Tabata" },
  { name: "Fatuma Salum", phone: "0768 234 567", mahali: "Magomeni" },
  { name: "Joseph Mwakyusa", phone: "0745 678 901", mahali: "Ubungo" },
  { name: "Rehema Msuya", phone: "0719 012 345", mahali: "Ilala" },
  { name: "Michael Mbwana", phone: "0782 345 678", mahali: "Mbezi" },
  { name: "Zainabu Juma", phone: "0756 789 012", mahali: "Mwananyamala" },
].map { |attrs| Customer.create!(attrs) }

puts "  ✅ #{customers.size} customers created"

# ============================================================
# 3. TV Brands, Sizes, Tatizos
# ============================================================
puts "📺 Creating TV brands, sizes, tatizos..."

tv_brands = ["Samsung", "LG", "Sony", "TCL", "Hisense", "Panasonic"].map do |name|
  TvBrand.find_or_create_by!(name: name)
end

tv_sizes = [32, 40, 43, 50, 55, 65].map do |size|
  TvSize.find_or_create_by!(size: size)
end

tatizos = [
  "No Power", "No Picture", "No Sound", "Screen Broken",
  "Backlight Issue", "Board Fault", "T-Con Fault", "COF Damage"
].map do |name|
  Tatizo.find_or_create_by!(name: name)
end

puts "  ✅ #{tv_brands.size} brands, #{tv_sizes.size} sizes, #{tatizos.size} tatizos"

# ============================================================
# 4. Spare Categories & Spares
# ============================================================
puts "🔧 Creating spares..."

spare_categories = ["T-Con Boards", "Power Boards", "Main Boards", "COF", "Backlight"].map do |name|
  SpareCategory.find_or_create_by!(name: name, code: name.upcase.gsub(" ", "")[0..5])
end

spares = []
spare_categories.each_with_index do |cat, i|
  3.times do |j|
    spares << Spare.create!(
      spare_category: cat,
      name: "#{cat.name} Model #{i}-#{j}",
      part_number: "PN-#{cat.code}-#{100 + i * 10 + j}",
      unit_cost: [25000, 35000, 45000, 55000].sample,
      selling_price: [50000, 70000, 90000].sample,
      quantity: rand(5..30),
      reorder_level: 5
    )
  end
end

puts "  ✅ #{spares.size} spares created"

# ============================================================
# 5. Activities za miezi yote 12
# ============================================================
puts "📊 Creating activities for all 12 months..."

current_year = Date.current.year
total_activities = 0

# Idadi ya activities kwa kila mwezi (ili graph ionekane vizuri)
monthly_counts = {
  1 => 8,   # Jan
  2 => 12,  # Feb
  3 => 15,  # Mar
  4 => 10,  # Apr
  5 => 18,  # May
  6 => 22,  # Jun
  7 => 20,  # Jul
  8 => 16,  # Aug
  9 => 14,  # Sep
  10 => 25, # Oct
  11 => 19, # Nov
  12 => 10  # Dec
}

monthly_counts.each do |month, count|
  count.times do |i|
    day = rand(1..28)
    date_in = Date.new(current_year, month, day)

    # Bei tofauti kwa kila activity
    starting_price = [80000, 100000, 150000, 200000, 250000, 300000].sample
    price = starting_price - [0, 5000, 10000, 20000].sample
    labour_charge = [15000, 20000, 25000, 30000].sample

    # Spares zilizotumika
    num_spares = rand(0..2)
    selected_spares = spares.sample(num_spares)
    spare_cost = selected_spares.sum(&:unit_cost)

    gross_profit = price - labour_charge - spare_cost

    activity = Activity.create!(
      user: User.first || User.create!(
        email: "admin@tour.com",
        password: "password123",
        password_confirmation: "password123",
        first_name: "Admin",
        last_name: "Tour",
        confirmed_at: Time.current
      ),
      customer: customers.sample,
      tv_brand: tv_brands.sample,
      tv_size: tv_sizes.sample,
      tatizo: tatizos.sample,
      date_in: date_in,
      date_out: date_in + rand(1..5).days,
      starting_price: starting_price,
      price: price,
      labour_charge: labour_charge,
      gross_profit: gross_profit,
      status: %w[received diagnosing in_repair completed delivered].sample,
      model_no: "MDL#{rand(1000..9999)}",
      board_number: "BN#{rand(1000..9999)}",
      tcon_number: "TC#{rand(1000..9999)}",
      cof_number: "CF#{rand(1000..9999)}",
      panel_number: "PN#{rand(1000..9999)}",
      number_of_cof: rand(1..3),
      remarks: "Activity #{i + 1} for #{Date::MONTHNAMES[month]}"
    )

    # Ongeza spares kwenye activity
    selected_spares.each do |spare|
      ActivitySpare.create!(
        activity: activity,
        spare: spare,
        quantity: rand(1..2)
      )
    end

    total_activities += 1
  end
end

puts "  ✅ #{total_activities} activities created"

# ============================================================
# 6. Expenses za miezi yote 12
# ============================================================
puts "💰 Creating expenses for all 12 months..."

expense_categories = ["electricity", "rent", "transport", "internet", "salary"]

monthly_counts.each_key do |month|
  rand(2..4).times do
    day = rand(1..28)
    Expense.create!(
      user: User.first,
      category: expense_categories.sample,
      description: "Expense for #{Date::MONTHNAMES[month]}",
      amount: [50000, 100000, 150000, 200000].sample,
      spent_on: Date.new(current_year, month, day)
    )
  end
end

puts "  ✅ Expenses created"

# ============================================================
# 7. Muhtasari
# ============================================================
puts ""
puts "=" * 50
puts "🎉 Seed completed!"
puts "=" * 50
puts "  👥 Customers:      #{Customer.count}"
puts "  📺 TV Brands:      #{TvBrand.count}"
puts "  📏 TV Sizes:       #{TvSize.count}"
puts "  🔧 Spares:         #{Spare.count}"
puts "  📊 Activities:     #{Activity.count}"
puts "  💰 Expenses:       #{Expense.count}"
puts ""
puts "  Monthly breakdown:"
monthly_counts.each do |month, count|
  puts "    #{Date::MONTHNAMES[month].ljust(10)}: #{count} activities"
end
puts ""
puts "  👤 Login: admin@tour.com / password123"
puts "=" * 50