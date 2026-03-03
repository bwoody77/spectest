component Popover2() {
  @state {
    open: false
  }

  @actions {
    toggle() { open = open == false }
    close() { open = false }
  }

  block {
    // Trigger (inline)
    block {
      on click: toggle()
      @slot("trigger")
    }

    // Backdrop — light overlay, click to dismiss
    block {
      visibility: open == true
      position: "fixed"
      top: 0px
      left: 0px
      right: 0px
      bottom: 0px
      z-index: 899
      background: "rgba(0, 0, 0, 0.08)"
      on click: close()
    }

    // Floating panel — centered like a lightweight modal
    block {
      visibility: open == true
      position: "fixed"
      top: 50%
      left: 50%
      transform: "translate(-50%, -50%)"
      z-index: 900
      min-width: 240px
      max-width: 90vw
      padding: spacing.4
      background: semantic.surface
      border: borders.default
      border-radius: 12px
      shadow: elevation.floating
      layout: vertical, gap: spacing.2

      // Close button row
      block {
        layout: horizontal, justify: end
        block {
          width: 28px
          height: 28px
          border-radius: 6px
          cursor: "pointer"
          layout: horizontal, align: center, justify: center
          on click: close()
          on hover { background: semantic.surface-raised }
          text("\u00D7") { style: type.body-md, color: semantic.text-tertiary }
        }
      }

      @slot("content")
    }
  }
}
