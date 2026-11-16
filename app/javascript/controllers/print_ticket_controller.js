import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  print() {
    // Ongeza class "printing-ticket" kwenye body
    document.body.classList.add("printing-ticket")
    
    // Print
    window.print()
    
    // Ondoa class baada ya print
    document.body.classList.remove("printing-ticket")
  }
}