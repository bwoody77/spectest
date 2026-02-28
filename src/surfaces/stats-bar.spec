// StatsBar — Enhanced for Gate #22
// Uses: Stat component (Issue #17), Card (Issue #17), Progress (Issue #19),
//   hover states (Issue #53), transitions (Issue #52), gradients (Issue #54),
//   shadows (Issue #54), transforms (Issue #54), responsive layout (Issue #58)

surface StatsBar(total, done, inProgress, todo, themePreset) {
  @computed {
    donePercent: total > 0 ? (done * 100 / total) : 0
    inProgressPercent: total > 0 ? (inProgress * 100 / total) : 0
    todoPercent: total > 0 ? (todo * 100 / total) : 0

    accentColor: match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    cardRadius: match themePreset { "enterprise" -> "4px", "social" -> "16px", "minimal" -> "0px", "playful" -> "12px", _ -> "8px" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }
  }

  layout: grid, columns: responsive("1fr", md: "1fr 1fr", lg: "1fr 1fr 1fr 1fr"), gap: spacing.4

  // Total Tasks card
  Card() {
    block {
      padding: spacing.4
      border-radius: cardRadius
      background: "linear-gradient(135deg, #eef2ff, #e0e7ff)"
      transition: "transform 200ms ease, shadow 200ms ease"
      cursor: "pointer"
      layout: vertical, gap: spacing.3

      on hover {
        transform: "translateY(-2px)"
        shadow: elevation.layered
      }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "list", size: "22px", color: "#6366f1")
        text("Total Tasks") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
      }
      Stat(value: "{total}", label: "tasks")
    }
  }

  // Done card
  Card() {
    block {
      padding: spacing.4
      border-radius: cardRadius
      background: "linear-gradient(135deg, #ecfdf5, #d1fae5)"
      transition: "transform 200ms ease, shadow 200ms ease"
      cursor: "pointer"
      layout: vertical, gap: spacing.3

      on hover {
        transform: "translateY(-2px)"
        shadow: elevation.layered
      }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "check", size: "22px", color: "#10b981")
        text("Completed") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
      }
      Stat(value: "{done}", label: "done")
      Progress(value: donePercent, label: "completion")
    }
  }

  // In Progress card
  Card() {
    block {
      padding: spacing.4
      border-radius: cardRadius
      background: "linear-gradient(135deg, #fffbeb, #fef3c7)"
      transition: "transform 200ms ease, shadow 200ms ease"
      cursor: "pointer"
      layout: vertical, gap: spacing.3

      on hover {
        transform: "translateY(-2px)"
        shadow: elevation.layered
      }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "loader", size: "22px", color: "#f59e0b")
        text("In Progress") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
      }
      Stat(value: "{inProgress}", label: "active")
      Progress(value: inProgressPercent, label: "progress")
    }
  }

  // Todo card
  Card() {
    block {
      padding: spacing.4
      border-radius: cardRadius
      background: "linear-gradient(135deg, #f8fafc, #e2e8f0)"
      transition: "transform 200ms ease, shadow 200ms ease"
      cursor: "pointer"
      layout: vertical, gap: spacing.3

      on hover {
        transform: "translateY(-2px)"
        shadow: elevation.layered
      }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "circle", size: "22px", color: "#64748b")
        text("Todo") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
      }
      Stat(value: "{todo}", label: "remaining")
      Progress(value: todoPercent, label: "backlog")
    }
  }
}
