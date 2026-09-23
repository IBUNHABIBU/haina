import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "openIcon", "closeIcon", "overlay"]

  connect() {
    console.log("Mobile menu controller connected")
    this.isOpen = false
    this.updateIcons()
    this.setupEventListeners()
  }

  disconnect() {
    this.removeEventListeners()
    // Clean up body class when controller disconnects
    document.body.classList.remove('overflow-hidden')
  }

  toggle() {
    console.log("Toggle clicked", this.isOpen)
    this.isOpen = !this.isOpen
    this.updateMenu()
    this.updateIcons()
    this.updateOverlay()
    
    // Update ARIA attribute
    const button = this.element.querySelector('[aria-controls="mobile-menu"]')
    if (button) {
      button.setAttribute('aria-expanded', this.isOpen)
    }
  }

  close(event) {
    // Prevent closing if clicking inside the menu
    if (event && event.target.closest('[data-mobile-menu-target="menu"]')) {
      return
    }
    
    console.log("Closing menu")
    this.isOpen = false
    this.updateMenu()
    this.updateIcons()
    this.updateOverlay()
    
    // Update ARIA attribute
    const button = this.element.querySelector('[aria-controls="mobile-menu"]')
    if (button) {
      button.setAttribute('aria-expanded', 'false')
    }
  }

  updateMenu() {
    if (this.isOpen) {
      // Use translate classes for smooth slide animation
      this.menuTarget.classList.remove('translate-x-full', 'hidden')
      this.menuTarget.classList.add('translate-x-0')
      document.body.classList.add('overflow-hidden')
    } else {
      this.menuTarget.classList.add('translate-x-full')
      this.menuTarget.classList.remove('translate-x-0')
      document.body.classList.remove('overflow-hidden')
      
      // Add hidden class after animation completes
      setTimeout(() => {
        if (!this.isOpen) {
          this.menuTarget.classList.add('hidden')
        }
      }, 300) // Match transition duration
    }
  }

  updateIcons() {
    if (this.isOpen) {
      this.openIconTarget.classList.add('hidden')
      this.closeIconTarget.classList.remove('hidden')
    } else {
      this.openIconTarget.classList.remove('hidden')
      this.closeIconTarget.classList.add('hidden')
    }
  }

  updateOverlay() {
    if (this.isOpen) {
      this.overlayTarget.classList.remove('hidden')
      // Small delay for fade-in effect
      setTimeout(() => {
        this.overlayTarget.classList.add('opacity-100')
        this.overlayTarget.classList.remove('opacity-0')
      }, 10)
    } else {
      this.overlayTarget.classList.remove('opacity-100')
      this.overlayTarget.classList.add('opacity-0')
      setTimeout(() => {
        if (!this.isOpen) {
          this.overlayTarget.classList.add('hidden')
        }
      }, 300)
    }
  }

  setupEventListeners() {
    this.boundHandleEscape = this.handleEscape.bind(this)
    this.boundHandleResize = this.handleResize.bind(this)
    document.addEventListener('keydown', this.boundHandleEscape)
    window.addEventListener('resize', this.boundHandleResize)
  }

  removeEventListeners() {
    document.removeEventListener('keydown', this.boundHandleEscape)
    window.removeEventListener('resize', this.boundHandleResize)
  }

  handleEscape(event) {
    if (event.key === 'Escape' && this.isOpen) {
      this.close(event)
    }
  }

  handleResize() {
    // Close menu on window resize if open (better UX for responsive)
    if (this.isOpen && window.innerWidth >= 1024) {
      this.close()
    }
  }
}