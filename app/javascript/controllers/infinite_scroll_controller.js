import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "container"]

  connect() {
    this.createObserver()
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  createObserver() {
    this.observer = new IntersectionObserver(
      (entries) => this.handleIntersect(entries),
      {
        threshold: 0.5,
        rootMargin: "100px",
      }
    )

    if (this.hasTriggerTarget) {
      this.observer.observe(this.triggerTarget)
    }
  }

  handleIntersect(entries) {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        this.loadMore()
      }
    })
  }

  loadMore() {
    const link = this.triggerTarget.querySelector("a")
    if (link) {
      link.click()
    }
  }
} 