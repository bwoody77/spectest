// Toggle — custom toggle/switch with event forwarding
component Toggle2(label: string, checked: boolean = false, disabled: boolean = false) {
  button {
    disabled: disabled
    border: "none"
    background: "transparent"
    padding: 0
    layout: horizontal, gap: 10px, align: center
    cursor: match disabled {
      true -> "default",
      _ -> "pointer"
    }
    opacity: match disabled {
      true -> 0.5,
      _ -> 1
    }

    on click: emit("change", checked == false)

    text(label) {
      style: type.body-md
      weight: 500
      color: semantic.text-secondary
    }

    // Track — unchecked state
    block {
      visibility: checked == false
      width: 44px
      height: 24px
      border-radius: token.toggle-radius
      background: token.toggle-trackBg

      // Thumb left
      block {
        width: 18px
        height: 18px
        border-radius: 9999px
        background: token.toggle-thumbBg
        shadow: "0 1px 3px rgba(0,0,0,0.15)"
        margin: 3px
      }
    }

    // Track — checked state
    block {
      visibility: checked == true
      width: 44px
      height: 24px
      border-radius: token.toggle-radius
      background: token.toggle-trackBgOn
      layout: horizontal, justify: end

      // Thumb right
      block {
        width: 18px
        height: 18px
        border-radius: 9999px
        background: token.toggle-thumbBg
        shadow: "0 1px 3px rgba(0,0,0,0.15)"
        margin: 3px
      }
    }
  }
}
