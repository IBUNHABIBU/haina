import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    document.addEventListener('click', this.closeOnClickOutside.bind(this))

    console.log("dropdown is working")
  }

  disconnect() {
    document.removeEventListener('click', this.closeOnClickOutside.bind(this))
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle('hidden')
    console.log(this.menuTarget.classList.toggle('hidden'))
  }

  close() {
    this.menuTarget.classList.add('hidden')
    
    console.log("close", this.menuTarget.classList.toggle('hidden'))
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  showAll() {
    const event = new CustomEvent('show-all-columns')
    document.dispatchEvent(event)
    this.close()
  }

  hideAll() {
    const event = new CustomEvent('hide-all-columns')
    document.dispatchEvent(event)
    this.close()
  }

  resetDefaults() {
    const event = new CustomEvent('reset-columns')
    document.dispatchEvent(event)
    this.close()
  }
}