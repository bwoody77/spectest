// Badge2 — inline status badge
// Limitation: padding only supports single value (TS uses 2px 10px),
// and display:inline-flex not available (renders as block div, not inline span)
component Badge2(text: string, variant: string = "neutral") {
  block {
    layout: horizontal, gap: 4px, align: center
    padding: spacing.2
    border-radius: token.badge-radius
    background: match variant {
      "info" -> token.badge-info-bg,
      "success" -> token.badge-success-bg,
      "warning" -> token.badge-warning-bg,
      "error" -> token.badge-error-bg,
      "neutral" -> token.badge-neutral-bg,
      _ -> token.badge-neutral-bg
    }
    role: "status"

    text(text) {
      style: type.label-sm
      weight: 500
      color: match variant {
        "info" -> token.badge-info-color,
        "success" -> token.badge-success-color,
        "warning" -> token.badge-warning-color,
        "error" -> token.badge-error-color,
        "neutral" -> token.badge-neutral-color,
        _ -> token.badge-neutral-color
      }
    }
  }
}
