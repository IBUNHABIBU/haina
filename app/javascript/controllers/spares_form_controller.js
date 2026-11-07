import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rows", "template"]

   connect() {
    // Initialize Tom Select kwenye rows zilizopo (kama zipo)
    this.rowsTarget.querySelectorAll("[data-spare-select]").forEach((select) => {
      this.initTomSelect(select)
    })
  }

  add(event) {
    event.preventDefault()
    const html = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, Date.now().toString())
    this.rowsTarget.insertAdjacentHTML("beforeend", html)

     // Initialize Tom Select kwenye row mpya
    const newRow = this.rowsTarget.lastElementChild
    const select = newRow.querySelector("[data-spare-select]")
    if (select) this.initTomSelect(select)
  }

  remove(event) {
    event.preventDefault()
    event.currentTarget.closest("[data-spare-row]")?.remove()
  }

  initTomSelect(select) {
    if (select.tomSelect) return  // Zuia duplicate

    select.tomSelect = new window.TomSelect(select, {
      create: false,
      sortField: { field: "text", direction: "asc" },
      maxOptions: 100,
      placeholder: select.dataset.placeholder || "Search spare...",
    })
  }
}
