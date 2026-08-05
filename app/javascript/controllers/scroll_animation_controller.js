import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["animate"]
  static classes = ["visible"]
  
  connect() {
    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            setTimeout(() => {
              entry.target.classList.add(this.visibleClass)
            }, parseInt(entry.target.dataset.delay || 0))
          }
        })
      },
      { threshold: 0.1 }
    )
    
    // Observe all animation targets
    this.animateTargets.forEach(target => {
      this.observer.observe(target)
    })
  }
  
  disconnect() {
    this.observer.disconnect()
  }
}