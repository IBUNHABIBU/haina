import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "header"]

  connect() {
    // Add context menu listeners to all headers
    
    console.log("Context menu is working")
    this.headers = this.headerTargets
    this.headers.forEach(header => {
      header.addEventListener('contextmenu', this.showMenu.bind(this))
    })
    
    document.addEventListener('click', this.hideMenu.bind(this))
  }

  disconnect() {
    this.headers.forEach(header => {
      header.removeEventListener('contextmenu', this.showMenu.bind(this))
    })
    document.removeEventListener('click', this.hideMenu.bind(this))
  }

  showMenu(event) {
    event.preventDefault()
    event.stopPropagation()
    
    const header = event.currentTarget
    const columnName = header.dataset.column
    
    if (!columnName || columnName === 'actions') return
    
    this.menuTarget.style.display = 'block'
    this.menuTarget.style.left = `${Math.min(event.clientX, window.innerWidth - 200)}px`
    this.menuTarget.style.top = `${Math.min(event.clientY, window.innerHeight - 150)}px`
    this.menuTarget.dataset.column = columnName
    
    // Highlight the column
    header.classList.add('bg-blue-50')
  }

  hideMenu() {
    this.menuTarget.style.display = 'none'
    this.headers.forEach(header => {
      header.classList.remove('bg-blue-50')
    })
  }

  hideColumn() {
    const columnName = this.menuTarget.dataset.column
    const checkbox = document.querySelector(`.column-toggle[data-column="${columnName}"]`)
    if (checkbox) {
      checkbox.checked = false
      checkbox.dispatchEvent(new Event('change'))
    }
    this.hideMenu()
  }

  showAllColumns() {
    const event = new CustomEvent('show-all-columns')
    document.dispatchEvent(event)
    this.hideMenu()
  }

  resetDefaults() {
    const event = new CustomEvent('reset-columns')
    document.dispatchEvent(event)
    this.hideMenu()
  }
}