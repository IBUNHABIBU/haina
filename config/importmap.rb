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
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
pin "chart.js" # @4.6.1
pin "date-fns" # @4.4.0
pin "chartkick" # @5.0.1
