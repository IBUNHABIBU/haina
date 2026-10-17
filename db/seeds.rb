# Idempotent seed data for the repair-management module.
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
