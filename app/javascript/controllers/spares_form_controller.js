import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rows", "template"]

  add(event) {
    event.preventDefault()
    const html = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, Date.now().toString())
    this.rowsTarget.insertAdjacentHTML("beforeend", html)
  }

  remove(event) {
    event.preventDefault()
    event.currentTarget.closest("[data-spare-row]")?.remove()
  }
}
