import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static values = {
    storageKey: { type: String, default: "selectedSidebarMenu" }
  }

  connect() {
    this.isOpen = false
    const persisted = window.localStorage.getItem(this.storageKeyValue)
    this.selectedKey = persisted || "Dashboard"
    this.open = this.open.bind(this)
    this.close = this.close.bind(this)
    window.addEventListener("sidebar:open", this.open)
    window.addEventListener("sidebar:close", this.close)
    this.render()
  }

  disconnect() {
    window.removeEventListener("sidebar:open", this.open)
    window.removeEventListener("sidebar:close", this.close)
  }

  toggle(event) {
    event.preventDefault()
    const { key } = event.params
    this.selectedKey = this.selectedKey === key ? "" : key
    window.localStorage.setItem(this.storageKeyValue, this.selectedKey)
    this.render()
  }

  render() {
    this.element.classList.toggle("translate-x-0", this.isOpen)
    this.element.classList.toggle("-translate-x-full", !this.isOpen)

    this.contentTargets.forEach((content) => {
      const isActive = content.dataset.sidebarKey === this.selectedKey
      content.classList.toggle("block", isActive)
      content.classList.toggle("hidden", !isActive)

      const trigger = content.closest("li")?.querySelector("[data-sidebar-key-param]")
      if (!trigger) return

      trigger.classList.toggle("menu-item-active", isActive)
      trigger.classList.toggle("menu-item-inactive", !isActive)

      const icon = trigger.querySelector("svg")
      if (icon) {
        icon.classList.toggle("menu-item-icon-active", isActive)
        icon.classList.toggle("menu-item-icon-inactive", !isActive)
      }

      const arrow = trigger.querySelector(".menu-item-arrow")
      if (arrow) {
        arrow.classList.toggle("menu-item-arrow-active", isActive)
        arrow.classList.toggle("menu-item-arrow-inactive", !isActive)
      }
    })
  }

  open() {
    this.isOpen = true
    this.render()
  }

  close() {
    this.isOpen = false
    this.render()
  }
}
