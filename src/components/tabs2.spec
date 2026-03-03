component Tabs2(tabs: array, activeTab: string = "") {
  block {
    layout: vertical

    // Tab bar
    block {
      layout: horizontal, gap: 0px
      border-bottom: borders.default

      each tabs as tab {
        block {
          padding: spacing.3
          cursor: "pointer"
          on click: emit("change", tab.id)
          on hover { background: semantic.surface-raised }

          text(tab.label) {
            style: type.label-md
            font-weight: match tab.id == activeTab { true -> 600, _ -> 400 }
            color: match tab.id == activeTab { true -> semantic.interactive, _ -> semantic.text-secondary }
          }
        }
      }
    }

    // Content area
    block {
      padding: spacing.4
      @children
    }
  }
}
