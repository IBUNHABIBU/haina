import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (this.element.tomSelect) return

    // Tumia window.TomSelect badala ya TomSelect
    this.element.tomSelect = new window.TomSelect(this.element, {
      create: false,
      sortField: { field: "text", direction: "asc" },
      maxOptions: 100,
      placeholder: this.element.dataset.placeholder || "Search...",
    })
  }

  disconnect() {
    if (this.element.tomSelect) {
      this.element.tomSelect.destroy()
      this.element.tomSelect = null
    }
  }
}