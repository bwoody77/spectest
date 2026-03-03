component Timeline2(items: array) {
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

          block {
            width: 12px
            height: 12px
            border-radius: 9999px
            background: match item.status {
              "completed" -> "#22c55e", "active" -> "#3b82f6",
              "error" -> "#ef4444", _ -> "#9ca3af"
            }
          }
          block {
            visibility: index != items.length - 1
            width: 2px
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
            visibility: item.date != ""
            style: type.caption
            color: semantic.text-tertiary
          }
          text(item.title) { style: type.body-md, color: semantic.text-primary }
          text(item.description) {
            visibility: item.description != ""
            style: type.body-md
            color: semantic.text-secondary
          }
        }
      }
    }
  }
}
