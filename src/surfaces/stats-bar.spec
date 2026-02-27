// StatsBar — metric cards with Icon + template strings

surface StatsBar(total, done, inProgress, todo, themePreset) {
  @computed {
    stat1Bg: match themePreset { "enterprise" -> "#dbeafe", "social" -> "#ede9fe", "minimal" -> "#f5f5f5", "playful" -> "#ffedd5", _ -> "#dbeafe" }
    stat2Bg: match themePreset { "enterprise" -> "#d1fae5", "social" -> "#e9d5ff", "minimal" -> "#f5f5f5", "playful" -> "#fef08a", _ -> "#d1fae5" }
    stat3Bg: match themePreset { "enterprise" -> "#fef3c7", "social" -> "#fae8ff", "minimal" -> "#f5f5f5", "playful" -> "#fed7aa", _ -> "#fef3c7" }
    stat4Bg: match themePreset { "enterprise" -> "#e2e8f0", "social" -> "#ddd6fe", "minimal" -> "#f5f5f5", "playful" -> "#fecaca", _ -> "#e2e8f0" }
    iconAccent: match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    padInner: match themePreset { "enterprise" -> "6px 10px", "social" -> "12px", "minimal" -> "20px", "playful" -> "16px", _ -> "12px" }
    cardRadius: match themePreset { "enterprise" -> "2px", "social" -> "20px", "minimal" -> "0px", "playful" -> "16px", _ -> "8px" }
    statsGap: match themePreset { "enterprise" -> "8px", "social" -> "16px", "minimal" -> "24px", "playful" -> "16px", _ -> "12px" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
  }

  layout: horizontal, gap: statsGap, align: center

  block {
    padding: padInner
    background: stat1Bg
    border-radius: cardRadius
    layout: horizontal, gap: statsGap, align: center
    Icon(name: "list", size: "18px", color: iconAccent)
    text("Total: {total}") { style: type.label-md, color: textPrimary }
  }
  block {
    padding: padInner
    background: stat2Bg
    border-radius: cardRadius
    layout: horizontal, gap: statsGap, align: center
    Icon(name: "check", size: "18px", color: "#10b981")
    text("Done: {done}") { style: type.label-md, color: textPrimary }
  }
  block {
    padding: padInner
    background: stat3Bg
    border-radius: cardRadius
    layout: horizontal, gap: statsGap, align: center
    Icon(name: "loader", size: "18px", color: "#f59e0b")
    text("In Progress: {inProgress}") { style: type.label-md, color: textPrimary }
  }
  block {
    padding: padInner
    background: stat4Bg
    border-radius: cardRadius
    layout: horizontal, gap: statsGap, align: center
    Icon(name: "circle", size: "18px", color: "#64748b")
    text("Todo: {todo}") { style: type.label-md, color: textPrimary }
  }
}
