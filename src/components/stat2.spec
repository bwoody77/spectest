component Stat2(label: string, value: string, trend: string = "", trendValue: string = "", helpText: string = "") {
  block {
    layout: vertical, gap: spacing.1

    text(label) { style: type.caption, color: semantic.text-tertiary }
    text(value) { style: type.heading-lg, color: semantic.text-primary }

    block {
      visibility: trend != ""
      layout: horizontal, gap: 4px, align: center
      text(match trend { "up" -> "↑", "down" -> "↓", _ -> "→" }) {
        style: type.label-sm
        color: match trend { "up" -> "#22c55e", "down" -> "#ef4444", _ -> semantic.text-tertiary }
      }
      text(trendValue) {
        visibility: trendValue != ""
        style: type.label-sm
        color: match trend { "up" -> "#22c55e", "down" -> "#ef4444", _ -> semantic.text-tertiary }
      }
    }

    text(helpText) { visibility: helpText != "", style: type.caption, color: semantic.text-tertiary }
  }
}
