import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { status: String }
  static targets = ["field"]

  connect() {
    this.toggle()
  }

  toggle() {
    const statusSelect = this.element.querySelector("#activity_status")
    if (!statusSelect) return

    const currentStatus = statusSelect.value
    const isMatch = currentStatus === this.statusValue

    this.fieldTarget.style.display = isMatch ? "block" : "none"
  }
}