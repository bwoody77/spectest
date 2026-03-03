component Accordion2(items: array) {
  @state {
    openIds: []
  }

  @actions {
    toggle(id) {
      openIds = match openIds.includes(id) {
        true -> openIds.filter(x => x != id),
        _ -> openIds.concat([id])
      }
    }
  }

  block {
    layout: vertical
    border: borders.default
    border-radius: 8px
    overflow: "hidden"

    each items as item {
      block {
        layout: vertical

        // Header button
        block {
          layout: horizontal, gap: spacing.2, align: center
          padding: spacing.3
          cursor: "pointer"
          background: semantic.surface
          border-bottom: borders.default
          on click: toggle(item.id)
          on hover { background: semantic.surface-raised }

          text(item.title) {
            style: type.body-md
            weight: 500
            color: semantic.text-primary
            grow: true
          }
          text(match openIds.includes(item.id) { true -> "−", _ -> "+" }) {
            style: type.body-md
            color: semantic.text-tertiary
          }
        }

        // Content panel
        block {
          max-height: match openIds.includes(item.id) { true -> "500px", _ -> "0" }
          overflow: "hidden"
          transition: "max-height 0.25s ease"

          block {
            padding: spacing.3
            text(item.content) {
              style: type.body-md
              color: semantic.text-secondary
            }
          }
        }
      }
    }
  }
}
