// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chart.js"
import "chartkick"
import "chartjs-adapter-date-fns"

import "trix"
import "@rails/actiontext"

if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker.register("/service-worker.js");
  });
}


// Zima auto-destroy
Chartkick.config.autoDestroy = false;

// Chora upya kila Turbo inapomaliza
document.addEventListener("turbo:load", () => {
  if (window.Chartkick) {
    Chartkick.eachChart((chart) => chart.redraw());
  }
});

// Muhimu: Chora upya pia baada ya Turbo cache preview
document.addEventListener("turbo:before-cache", () => {
  if (window.Chartkick) {
    Chartkick.eachChart((chart) => chart.destroy());
  }
});

