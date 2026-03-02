// Button2 — native <button> with event forwarding
component Button2(label: string, variant: string = "primary", disabled: boolean = false, loading: boolean = false) {
  button {
    disabled: disabled
    layout: horizontal, align: center, justify: center
    padding-x: spacing.4
    padding-y: spacing.2
    border-radius: token.btn-radius
    shadow: token.btn-shadow
    font-weight: token.btn-fontWeight
    text-transform: token.btn-textTransform
    letter-spacing: token.btn-letterSpacing
    transition: "all .15s ease"
    cursor: match disabled {
      true -> "default",
      _ -> "pointer"
    }
    opacity: match loading {
      true -> 0.7,
      _ -> match disabled {
        true -> 0.5,
        _ -> 1
      }
    }
    background: match variant {
      "primary" -> token.btn-primary-bg,
      "secondary" -> token.btn-secondary-bg,
      "ghost" -> "transparent",
      "destructive" -> token.btn-destructive-bg,
      _ -> token.btn-primary-bg
    }
    border: match variant {
      "secondary" -> token.btn-secondary-border,
      _ -> "none"
    }

    on hover {
      background: match variant {
        "primary" -> token.btn-primary-hover,
        "secondary" -> token.btn-secondary-hover,
        "ghost" -> token.btn-ghost-hover,
        "destructive" -> token.btn-destructive-hover,
        _ -> token.btn-primary-hover
      }
    }

    on active {
      transform: "scale(.97)"
    }

    on click: emit("click")

    text(label) {
      style: type.body-md
      font-weight: token.btn-fontWeight
      color: match variant {
        "primary" -> token.btn-primary-color,
        "secondary" -> token.btn-secondary-color,
        "ghost" -> token.btn-ghost-color,
        "destructive" -> token.btn-destructive-color,
        _ -> token.btn-primary-color
      }
    }
  }
}
