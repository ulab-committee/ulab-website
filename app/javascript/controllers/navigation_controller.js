import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "details", "summary" ]

  connect() {
    if (window.matchMedia("(pointer: fine)").matches) {
      this.detailsTarget.setAttribute('open', true)
      this.summaryTarget.style.display = 'none'
    }
  }
}
