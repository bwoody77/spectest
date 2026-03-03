component Tooltip2(text: string = "") {
  @state {
    visible: false
  }

  @actions {
    showTip() { delay("show", 300) { visible = true } }
    hideTip() {
      clearDelay("show")
      visible = false
    }
  }

  block {
    position: "relative"
    on mouse-enter: showTip()
    on mouse-leave: hideTip()

    @children

    // Tooltip bubble (above trigger)
    block {
      visibility: visible == true
      position: "absolute"
      z-index: 1000
      bottom: 100%
      left: 50%
      transform: "translateX(-50%)"
      margin: 8px
      padding: spacing.2
      background: "#1e293b"
      border-radius: 6px
      shadow: elevation.floating

      text(text) {
        style: type.label-sm
        color: "#f1f5f9"
      }
    }
  }
}
