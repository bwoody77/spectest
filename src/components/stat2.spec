component Stat2(label: string, value: string, trend: string = "", trendValue: string = "", helpText: string = "") {
  block {
    layout: vertical

    text(label) { style: type.body-md, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
    text(value) { style: type.heading-lg, color: semantic.text-primary }

    block {
      visibility: trend != ""
      layout: horizontal, gap: 4px, align: center
      text(match trend { "up" -> "↑", "down" -> "↓", _ -> "→" }) {
        style: type.body-md
        color: match trend { "up" -> "#22c55e", "down" -> "#ef4444", _ -> semantic.text-tertiary }
      }
      text(trendValue) {
        visibility: trendValue != ""
        style: type.body-md
        color: match trend { "up" -> "#22c55e", "down" -> "#ef4444", _ -> semantic.text-tertiary }
      }
    }

    text(helpText) { visibility: helpText != "", style: type.body-sm, color: semantic.text-tertiary }
  }
}
