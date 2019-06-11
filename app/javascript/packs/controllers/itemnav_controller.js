import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['item', 'itemContent']

  get selectedTab() {
    return Number.parseInt(this.data.get('selected-item'))
  }

  set selectedTab(index) {
    this.data.set('selected-item', index.toString())
    this.showTab()
  }

  connect() {
    this.showTab()
  }

  showTab() {
    this.itemContentTargets.forEach(itemContent => {
      if (this.itemContentTargets[this.selectedTab] === itemContent) {
        itemContent.removeAttribute('hidden')
      } else {
        itemContent.setAttribute('hidden', '')
      }
    })
    this.itemTargets.forEach(item => {
      if (this.itemTargets[this.selectedTab] === item) {
        item.classList.add('selected')
        item.setAttribute('aria-current', 'page')
      } else {
        item.classList.remove('selected')
        item.removeAttribute('aria-current')
      }
    })
  }

  select(event) {
    this.selectedTab = this.itemTargets.indexOf(event.target)
  }
}
