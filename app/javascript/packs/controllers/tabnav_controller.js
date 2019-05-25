import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["tab", "tabContent"]

  toggleVisibility() {
    this.tabContentTargets.forEach(tabContent => {
      if (`#${tabContent.id}` == location.hash) {
        tabContent.removeAttribute('hidden')
      } else {
        tabContent.setAttribute('hidden', '')
      }
    })
    this.tabTargets.forEach(tab => {
      if (tab.getAttribute('href') == location.hash) {
        tab.classList.add('selected')
        tab.setAttribute('aria-current', 'page')
      } else {
        tab.classList.remove('selected')
        tab.removeAttribute('aria-current')
      }
    })
  }
}
