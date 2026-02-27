// AnalyticsView — charts, metrics, and progress indicators

surface AnalyticsView {
  @source {
    stats: StatsAPI
    tasks: TasksAPI
  }

  @computed {
    total: stats != null ? stats.total : 0
    done: stats != null ? stats.done : 0
    inProgress: stats != null ? stats.inProgress : 0
    todo: stats != null ? stats.todo : 0
    doneLabel: "{done} completed"
    inProgressLabel: "{inProgress} in progress"
    todoLabel: "{todo} todo"

    taskList: tasks != null ? tasks : []
    highCount: taskList.filter(t -> t.priority == "high").length
    mediumCount: taskList.filter(t -> t.priority == "medium").length
    lowCount: taskList.filter(t -> t.priority == "low").length
    highLabel: "{highCount} high priority"
    mediumLabel: "{mediumCount} medium priority"
    lowLabel: "{lowCount} low priority"

    aliceCount: taskList.filter(t -> t.assignee == "Alice").length
    bobCount: taskList.filter(t -> t.assignee == "Bob").length
    carolCount: taskList.filter(t -> t.assignee == "Carol").length
    aliceLabel: "Alice: {aliceCount} tasks"
    bobLabel: "Bob: {bobCount} tasks"
    carolLabel: "Carol: {carolCount} tasks"
  }

  layout: vertical, gap: spacing.6

  text("Analytics") { style: type.heading-lg }

  // Loading
  block {
    aria-live: "polite"
    visibility: statsLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "loader", size: "18px", color: "#6366f1")
    text("Loading analytics...") { style: type.body-sm, color: semantic.text-secondary }
  }

  // Key metric cards
  block {
    layout: horizontal, gap: spacing.4

    block {
      padding: spacing.4
      background: "#eef2ff"
      border-radius: radius.lg
      layout: vertical, gap: spacing.2, align: center
      Icon(name: "list", size: "28px", color: "#6366f1")
      text("{total}") { style: type.heading-lg, color: palette.primary.500 }
      text("Total Tasks") { style: type.label-sm, color: semantic.text-secondary }
    }

    block {
      padding: spacing.4
      background: "#ecfdf5"
      border-radius: radius.lg
      layout: vertical, gap: spacing.2, align: center
      Icon(name: "check", size: "28px", color: "#10b981")
      text("{done}") { style: type.heading-lg, color: palette.success.500 }
      text("Completed") { style: type.label-sm, color: semantic.text-secondary }
    }

    block {
      padding: spacing.4
      background: "#fffbeb"
      border-radius: radius.lg
      layout: vertical, gap: spacing.2, align: center
      Icon(name: "loader", size: "28px", color: "#f59e0b")
      text("{inProgress}") { style: type.heading-lg, color: palette.warning.500 }
      text("In Progress") { style: type.label-sm, color: semantic.text-secondary }
    }

    block {
      padding: spacing.4
      background: palette.neutral.50
      border-radius: radius.lg
      layout: vertical, gap: spacing.2, align: center
      Icon(name: "circle", size: "28px", color: "#64748b")
      text("{todo}") { style: type.heading-lg, color: semantic.text-secondary }
      text("Todo") { style: type.label-sm, color: semantic.text-secondary }
    }
  }

  // Status breakdown
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Status Breakdown") { style: type.heading-md }

    block {
      padding: spacing.3
      background: "#ecfdf5"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "check", size: "18px", color: "#10b981")
      text(doneLabel) { style: type.body-md, color: palette.success.500 }
    }

    block {
      padding: spacing.3
      background: "#fffbeb"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "loader", size: "18px", color: "#f59e0b")
      text(inProgressLabel) { style: type.body-md, color: palette.warning.500 }
    }

    block {
      padding: spacing.3
      background: palette.neutral.50
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "circle", size: "18px", color: "#64748b")
      text(todoLabel) { style: type.body-md, color: semantic.text-secondary }
    }
  }

  // Priority breakdown
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Priority Breakdown") { style: type.heading-md }

    block {
      padding: spacing.3
      background: "#fef2f2"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "info", size: "18px", color: "#ef4444")
      text(highLabel) { style: type.body-md, color: palette.danger.500 }
    }

    block {
      padding: spacing.3
      background: "#fffbeb"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "info", size: "18px", color: "#f59e0b")
      text(mediumLabel) { style: type.body-md, color: palette.warning.500 }
    }

    block {
      padding: spacing.3
      background: "#ecfdf5"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "info", size: "18px", color: "#10b981")
      text(lowLabel) { style: type.body-md, color: palette.success.500 }
    }
  }

  // Workload distribution
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Workload Distribution") { style: type.heading-md }

    block {
      padding: spacing.3
      background: "#eef2ff"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "user", size: "18px", color: "#6366f1")
      text(aliceLabel) { style: type.body-md }
    }

    block {
      padding: spacing.3
      background: "#ecfdf5"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "user", size: "18px", color: "#10b981")
      text(bobLabel) { style: type.body-md }
    }

    block {
      padding: spacing.3
      background: "#fffbeb"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "user", size: "18px", color: "#f59e0b")
      text(carolLabel) { style: type.body-md }
    }
  }
}
