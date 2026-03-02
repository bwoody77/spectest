// Button2 — visual-equivalent button for theme comparison
// Note: not interactive (div, not <button>); needs native element + event forwarding
component Button2(label: string, variant: string = "primary", disabled: boolean = false, loading: boolean = false) {
  block {
    layout: horizontal, align: center, justify: center
    padding: spacing.2
    border-radius: token.btn-radius
    shadow: token.btn-shadow
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

    text(label) {
      style: type.body-md
      weight: 500
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
