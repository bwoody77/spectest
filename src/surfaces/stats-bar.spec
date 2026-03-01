// StatsBar — Enhanced for Gate #22
// Uses: Stat component (Issue #17), Card (Issue #17), Progress (Issue #19),
//   hover states (Issue #53), transitions (Issue #52), gradients (Issue #54),
//   shadows (Issue #54), transforms (Issue #54), responsive layout (Issue #58)

surface StatsBar(total, done, inProgress, todo) {
  @computed {
    donePercent: total > 0 ? (done * 100 / total) : 0
    inProgressPercent: total > 0 ? (inProgress * 100 / total) : 0
    todoPercent: total > 0 ? (todo * 100 / total) : 0
  }

  layout: grid, columns: responsive("1fr", md: "1fr 1fr", lg: "1fr 1fr 1fr 1fr"), gap: spacing.4

  // Total Tasks card
  Card() {
    block {
      padding: spacing.4
      border-radius: radius.md
      background: gradient.stat-primary-subtle
      transition: transition.card-lift
      cursor: "pointer"
      layout: vertical, gap: spacing.3

      on hover {
        transform: transform.lift-sm
        shadow: elevation.layered
      }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "list", size: icon.lg, color: semantic.interactive)
        text("Total Tasks") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
      }
      Stat(value: "{total}", label: "tasks")
    }
  }

  // Done card
  Card() {
    block {
      padding: spacing.4
      border-radius: radius.md
      background: gradient.stat-success-subtle
      transition: transition.card-lift
      cursor: "pointer"
      layout: vertical, gap: spacing.3

      on hover {
        transform: transform.lift-sm
        shadow: elevation.layered
      }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "check", size: icon.lg, color: semantic.success)
        text("Completed") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
      }
      Stat(value: "{done}", label: "done")
      Progress(value: donePercent, label: "completion")
    }
  }

  // In Progress card
  Card() {
    block {
      padding: spacing.4
      border-radius: radius.md
      background: gradient.stat-warning-subtle
      transition: transition.card-lift
      cursor: "pointer"
      layout: vertical, gap: spacing.3

      on hover {
        transform: transform.lift-sm
        shadow: elevation.layered
      }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "loader", size: icon.lg, color: semantic.warning)
        text("In Progress") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
      }
      Stat(value: "{inProgress}", label: "active")
      Progress(value: inProgressPercent, label: "progress")
    }
  }

  // Todo card
  Card() {
    block {
      padding: spacing.4
      border-radius: radius.md
      background: gradient.stat-neutral-subtle
      transition: transition.card-lift
      cursor: "pointer"
      layout: vertical, gap: spacing.3

      on hover {
        transform: transform.lift-sm
        shadow: elevation.layered
      }

      block {
        layout: horizontal, gap: spacing.3, align: center
        Icon(name: "circle", size: icon.lg, color: semantic.text-muted)
        text("Todo") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
      }
      Stat(value: "{todo}", label: "remaining")
      Progress(value: todoPercent, label: "backlog")
    }
  }
}
