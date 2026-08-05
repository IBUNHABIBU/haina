import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    autoDismiss: { type: Boolean, default: true },
    duration: { type: Number, default: 5000 } // 5 seconds
  }

  connect() {
    console.log("Toast controller connected")
    
    if (this.autoDismissValue) {
      this.startTimer()
    }
  }

  disconnect() {
    this.clearTimer()
  }

  close() {
    // Add fade-out animation
    this.element.classList.add('opacity-0', 'transition-opacity', 'duration-300')
    
    // Remove after animation
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }

  startTimer() {
    this.timer = setTimeout(() => {
      this.close()
    }, this.durationValue)
  }

  clearTimer() {
    if (this.timer) {
      clearTimeout(this.timer)
    }
  }

  // Pause timer on hover
  pause() {
    this.clearTimer()
  }

  // Resume timer on mouse leave
  resume() {
    if (this.autoDismissValue) {
      this.startTimer()
    }
  }
}