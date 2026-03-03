// Checkbox — custom visual checkbox with event forwarding
component Checkbox2(label: string, checked: boolean = false, disabled: boolean = false) {
  button {
    disabled: disabled
    border: "none"
    background: "transparent"
    padding: 0
    layout: horizontal, gap: 10px, align: center
    opacity: match disabled {
      true -> 0.5,
      _ -> 1
    }
    cursor: match disabled {
      true -> "default",
      _ -> "pointer"
    }

    on click: emit("change", checked == false)

    // Unchecked box (visual)
    block {
      visibility: checked == false
      width: 18px
      height: 18px
      border-radius: token.checkbox-radius
      border: token.checkbox-border
      background: "transparent"
    }

    // Checked box with icon (visual)
    block {
      visibility: checked == true
      width: 18px
      height: 18px
      border-radius: token.checkbox-radius
      background: token.checkbox-checkedBg
      layout: horizontal, align: center, justify: center

      Icon(name: "check", size: "14px", color: "#ffffff")
    }

    text(label) {
      style: type.body-md
      weight: 500
      color: semantic.text-secondary
    }
  }
}
