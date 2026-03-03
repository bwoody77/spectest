component Sidebar2(sections: array, activeItem: string = "", collapsed: boolean = false, width: string = "240px", collapsedWidth: string = "56px") {
  block {
    width: collapsed ? collapsedWidth : width
    min-width: collapsed ? collapsedWidth : width
    height: 100%
    background: semantic.surface
    border-right: borders.default
    layout: vertical
    overflow: hidden
    transition: "width 200ms ease, min-width 200ms ease"
    role: "navigation"
    aria-label: "Sidebar navigation"

    // Collapse toggle — centered when collapsed
    block {
      visibility: collapsed == true
      padding: spacing.2
      layout: horizontal, justify: center
      block {
        width: 32px
        height: 32px
        border-radius: radius.md
        cursor: "pointer"
        layout: horizontal, align: center, justify: center
        on hover { background: semantic.surface-raised }
        on click: emit("collapse", false)
        text("\u00BB") { style: type.body-md, color: semantic.text-secondary }
      }
    }

    // Collapse toggle — end-aligned when expanded
    block {
      visibility: collapsed == false
      padding: spacing.2
      layout: horizontal, justify: end
      block {
        width: 32px
        height: 32px
        border-radius: radius.md
        cursor: "pointer"
        layout: horizontal, align: center, justify: center
        on hover { background: semantic.surface-raised }
        on click: emit("collapse", true)
        text("\u00AB") { style: type.body-md, color: semantic.text-secondary }
      }
    }

    // Sections
    block {
      layout: vertical, gap: spacing.1
      padding: spacing.2
      grow: true
      overflow: auto

      each sections as section {
        // Section heading
        block {
          visibility: collapsed == false && section.title != null
          padding: spacing.2
          text(section.title) {
            style: type.caption
            color: semantic.text-tertiary
            text-transform: uppercase
            letter-spacing: "0.05em"
          }
        }

        // Section items
        each section.items as item {
          block {
            layout: horizontal, gap: spacing.2, align: center
            padding: spacing.2
            border-radius: radius.md
            cursor: "pointer"
            background: item.id == activeItem ? semantic.surface-raised : "transparent"
            on hover { background: semantic.surface-raised }
            on click: emit("select", item.id)

            // Icon placeholder
            block {
              width: 24px
              min-width: 24px
              height: 24px
              layout: horizontal, align: center, justify: center
              text(item.icon != null ? item.icon : "\u2022") {
                style: type.body-md
                color: item.id == activeItem ? semantic.interactive : semantic.text-secondary
              }
            }

            // Label (hidden when collapsed)
            block {
              visibility: collapsed == false
              text(item.label) {
                style: type.body-md
                color: item.id == activeItem ? semantic.text-primary : semantic.text-secondary
              }
            }
          }
        }
      }
    }
  }
}
