import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { status: String }
  static targets = ["container", "template"]

  connect() {
    this.toggle()
    // Sikiliza mabadiliko ya status
    this.statusSelect = this.element.closest("form")?.querySelector("#activity_status")
    if (this.statusSelect) {
      this.statusSelect.addEventListener("change", () => this.toggle())
    }
  }

  toggle() {
    if (!this.statusSelect) return

    const currentStatus = this.statusSelect.value
    const isMatch = currentStatus === this.statusValue

    // Kama ni irreparable, onyesha (kama bado haijaonyeshwa)
    if (isMatch) {
      if (this.containerTarget.innerHTML.trim() === "") {
        this.containerTarget.innerHTML = this.templateTarget.innerHTML
      }
      this.containerTarget.style.display = "block"
    } else {
      // Kama si irreparable, ficha (bila kufuta data)
      this.containerTarget.style.display = "none"
    }
  }
}