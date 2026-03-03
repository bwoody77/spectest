component Popover2() {
  @state {
    open: false
  }

  @actions {
    toggle() { open = open == false }
    close() { open = false }
  }

  block {
    position: "relative"

    // Trigger
    block {
      on click: toggle()
      @slot("trigger")
    }

    // Floating content (below trigger)
    block {
      visibility: open == true
      position: "absolute"
      z-index: 900
      top: 100%
      left: 0
      min-width: 200px
      margin: 8px
      padding: spacing.3
      background: semantic.surface
      border: borders.default
      border-radius: 8px
      shadow: elevation.floating

      @slot("content")
    }
  }
}
