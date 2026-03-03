component Breadcrumb2(items: array, separator: string = "/") {
  block {
    layout: horizontal, gap: 4px, align: center
    role: "navigation"
    aria-label: "Breadcrumb"

    each items as item, index {
      text(separator) {
        visibility: index > 0
        style: type.body-md
        color: semantic.text-tertiary
        opacity: 0.5
      }
      // Last item = plain text, others = clickable
      text(item.label) {
        visibility: index == items.length - 1
        style: type.body-md
        color: semantic.text-primary
      }
      block {
        visibility: index != items.length - 1
        cursor: "pointer"
        on click: emit("select", item)
        on hover { opacity: 0.8 }
        text(item.label) {
          style: type.body-md
          color: semantic.interactive
        }
      }
    }
  }
}
