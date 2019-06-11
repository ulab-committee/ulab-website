import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['slide']

  get incrementer() {
    return Number.parseInt(this.data.get('incrementer'))
  }

  set incrementer(value) {
    this.data.set('incrementer', value.toString())
    this.showSlide()
  }

  connect() {
    this.showSlide()
    if (this.data.has('advance')) {
      setInterval(() => this.next(), 10000)
    }
  }

  showSlide() {
    this.slideTargets.forEach((target, index) => target.style.display = index === this.incrementer ? 'block' : 'none')
  }

  next() {
    const incrementer = this.incrementer
    this.incrementer = incrementer === this.slideTargets.length - 1 ? 0 : incrementer + 1
  }

  previous() {
    const incrementer = this.incrementer
    this.incrementer = incrementer === 0 ? this.slideTargets.length - 1 : incrementer - 1
  }
}
