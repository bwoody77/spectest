component Timeline2(items: array) {
  // Note: the compiler doesn't yet support dynamic style expressions (match/ternary)
  // inside each loops, so dots and lines use static colors. Per-status coloring
  // requires a compiler enhancement to emit item property access in style bindings.
  block {
    layout: vertical
    role: "list"

    each items as item, index {
      block {
        layout: horizontal
        role: "listitem"

        // Track: dot + connector line
        block {
          layout: vertical, align: center
          width: 24px
          min-width: 24px

          // Status dot — static color (compiler limitation: no item.* in styles)
          block {
            width: 12px
            height: 12px
            min-width: 12px
            min-height: 12px
            border-radius: 9999px
            background: semantic.interactive
          }
          // Connector line
          block {
            visibility: index != items.length - 1
            width: 2px
            min-width: 2px
            grow: true
            min-height: 24px
            background: semantic.border
          }
        }

        // Content
        block {
          layout: vertical, gap: 2px
          padding: spacing.2
          grow: true

          text(item.date) {
            style: type.caption
            color: semantic.text-tertiary
          }
          text(item.title) { style: type.body-md, color: semantic.text-primary }
          text(item.description) {
            style: type.body-md
            color: semantic.text-secondary
          }
        }
      }
    }
  }
}
