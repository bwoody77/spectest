// TaskTable — filterable list with Buttons, each+index, components, Tooltip

surface TaskTable(themePreset, selectedTask, view) {
  @state {
    filter: "all"
  }

  @source {
    tasks: TasksAPI
  }

  @computed {
    taskList: tasks != null ? tasks : []
    filteredTasks: filter == "all" ? taskList : taskList.filter(t -> t.status == filter)
    taskCount: "{filteredTasks.length} tasks"
    hasNoResults: filteredTasks.length == 0

    surfaceBg: match themePreset { "enterprise" -> "#e2e8f0", "social" -> "#ede9fe", "minimal" -> "#f5f5f5", "playful" -> "#ffedd5", _ -> "#e2e8f0" }
    borderColor: match themePreset { "enterprise" -> "1px solid #94a3b8", "social" -> "1px solid #a78bfa", "minimal" -> "1px solid #d4d4d4", "playful" -> "1px solid #fb923c", _ -> "1px solid #94a3b8" }
    rowBg: match themePreset { "enterprise" -> "#f1f5f9", "social" -> "#f5f3ff", "minimal" -> "#ffffff", "playful" -> "#fff7ed", _ -> "#f1f5f9" }
    padOuter: match themePreset { "enterprise" -> "8px 12px", "social" -> "16px", "minimal" -> "24px 32px", "playful" -> "20px", _ -> "16px" }
    padInner: match themePreset { "enterprise" -> "6px 10px", "social" -> "12px", "minimal" -> "20px", "playful" -> "16px", _ -> "12px" }
    cardRadius: match themePreset { "enterprise" -> "2px", "social" -> "20px", "minimal" -> "0px", "playful" -> "16px", _ -> "8px" }
    cardGap: match themePreset { "enterprise" -> "6px", "social" -> "12px", "minimal" -> "20px", "playful" -> "14px", _ -> "12px" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }
  }

  @actions {
    setFilter(f) { filter = f }
    selectTask(t) {
      selectedTask = t
      view = "detail"
    }
  }

  layout: vertical, gap: cardGap

  text("Tasks") { style: type.heading-md, color: textPrimary }

  // Filter bar
  block {
    role: "toolbar"
    aria-label: "Task filters"
    padding: padInner
    background: surfaceBg
    border-radius: cardRadius
    layout: horizontal, gap: cardGap, align: center
    text(taskCount) { style: type.body-sm, color: textMuted }
    Button(label: "All", variant: "secondary") {
      on click: setFilter("all")
    }
    Button(label: "Todo", variant: "secondary") {
      on click: setFilter("todo")
    }
    Button(label: "In Progress", variant: "secondary") {
      on click: setFilter("in-progress")
    }
    Button(label: "Done", variant: "secondary") {
      on click: setFilter("done")
    }
  }

  // Loading indicator
  block {
    aria-live: "polite"
    visibility: tasksLoading
    padding: padOuter
    background: surfaceBg
    border-radius: cardRadius
    text("Loading tasks...") { style: type.body-sm, color: textMuted }
  }

  // Error display
  block {
    aria-live: "assertive"
    visibility: tasksError
    padding: padInner
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: cardRadius
    text("Failed to load tasks.") { style: type.body-sm, color: palette.danger.500 }
  }

  // Task rows
  each filteredTasks as task, index {
    block {
      role: "button"
      tabindex: "0"
      padding: padInner
      background: rowBg
      border: borderColor
      border-radius: cardRadius
      layout: horizontal, gap: cardGap, align: center
      on click: selectTask(task)
      text("{index}") { style: type.mono-sm, color: textMuted }
      block {
        layout: vertical, gap: cardGap
        text(task.title) { style: type.body-md, weight: 500, color: textPrimary }
        text(task.assignee) { style: type.body-sm, color: textMuted }
      }
      StatusBadge(task.status)
      Tooltip(text: "Priority: {task.priority}") {
        PriorityBadge(task.priority)
      }
    }
  }

  // Empty state
  block {
    aria-live: "polite"
    visibility: hasNoResults
    padding: padOuter
    background: surfaceBg
    border-radius: cardRadius
    text("No tasks match the current filter.") { style: type.body-sm, color: textMuted }
  }
}
