pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus",    to: "stimulus.min.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "chartjs-adapter-date-fns" # @3.0.0
# pin "date-fns" # @4.4.0
pin "chartkick" # @5.0.1
# Ondoa hizi (kama zipo):
# pin "chartjs-adapter-date-fns", to: "..."
# pin "date-fns", to: "..."

# Weka hii (toleo la bundle lenye date-fns ndani):
# Ondoa hii:
# pin "chartjs-adapter-date-fns", to: "https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns@3.0.0/+esm"

# Weka hii (UMD bundle — inaingiza adapter kwenye window):
pin "chartjs-adapter-date-fns", to: "https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns@3.0.0/dist/chartjs-adapter-date-fns.bundle.min.js"
# config/importmap.rb
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.2.0/dist/chart.js"
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"