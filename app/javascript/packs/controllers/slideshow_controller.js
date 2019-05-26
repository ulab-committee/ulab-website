import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "slide" ]

  connect() {
    this.showFirstSlide()
    if (this.data.has('advance')) {
      setInterval(() => this.next(), 10000)
    }
  }

  showFirstSlide() {
    this.showSlide()
  }

  showSlide() {
    this.slideTargets.forEach((target, index) => {
      target.style.display = index === Number.parseInt(this.data.get('incrementer')) ? 'block' : 'none'
    })
  }

  next() {
    const incrementer = Number.parseInt(this.data.get('incrementer'))
    this.data.set('incrementer', incrementer === this.slideTargets.length - 1 ? 0 : incrementer + 1)
    this.showSlide()
  }

  previous() {
    const incrementer = Number.parseInt(this.data.get('incrementer'))
    this.data.set('incrementer', incrementer === 0 ? this.slideTargets.length - 1 : incrementer - 1)
    this.showSlide()
  }
}
