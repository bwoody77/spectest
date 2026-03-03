component Drawer2(open: boolean = false, title: string = "") {
  @state {
    showing: false
  }

  @computed {
    panelTransform: match showing { true -> "translateX(0)", _ -> "translateX(-100%)" }
  }

  @actions {
    doOpen() {
      showing = true
      lockScroll()
      trapFocus()
    }
    doClose() {
      showing = false
      unlockScroll()
      releaseFocus()
      emit("close")
    }
  }

  @watch {
    open: {
      match open {
        true -> doOpen()
        _ -> doClose()
      }
    }
  }

  block {
    // Backdrop
    block {
      visibility: showing == true
      position: "fixed"
      top: 0px
      left: 0px
      right: 0px
      bottom: 0px
      z-index: 999
      background: "rgba(0, 0, 0, 0.4)"
      on click: doClose()
    }

    // Panel (left side)
    block {
      position: "fixed"
      top: 0px
      bottom: 0px
      left: 0px
      z-index: 1000
      width: 280px
      max-width: 90vw
      background: semantic.surface
      shadow: elevation.floating
      overflow: "auto"
      transition: "transform 0.25s ease"
      transform: panelTransform
      role: "dialog"
      aria-label: "Drawer"

      layout: vertical

      // Header
      block {
        layout: horizontal, justify: between, align: center
        padding: spacing.4
        border-bottom: borders.default

        text(title) {
          visibility: title != ""
          style: type.heading-sm
          color: semantic.text-primary
        }

        // Close button
        block {
          width: 32px
          height: 32px
          border-radius: 8px
          cursor: "pointer"
          layout: horizontal, align: center, justify: center
          on click: doClose()
          on hover {
            background: semantic.surface-raised
          }

          text("\u00D7") {
            style: type.heading-sm
            color: semantic.text-tertiary
          }
        }
      }

      // Body
      block {
        padding: spacing.4
        grow: true
        overflow: "auto"
        @children
      }
    }
  }
}
