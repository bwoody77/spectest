component Stat2(label: string, value: string, trend: string = "", trendValue: string = "", helpText: string = "") {
  block {
    layout: vertical

    text(label) { style: type.label-md, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
    text(value) { style: type.heading-md, color: semantic.text-primary, margin: "0" }

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

    text(helpText) { visibility: helpText != "", style: type.label-sm, color: semantic.text-tertiary }
  }
}
