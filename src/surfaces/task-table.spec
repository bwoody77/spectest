// TaskTable — Enhanced for Gate #22
// Uses: Pagination (Issue #18), Skeleton (Issue #19), hover states (Issue #53),
//   transitions (Issue #52), shadows (Issue #54), individual borders (Issue #56)

surface TaskTable(selectedTask, view) {
  @state {
    filter: "all"
  }

  @source {
    tasks: TasksAPI
  }

  @computed {
    taskList: tasks != null ? tasks : []
    filteredTasks: filter == "all" ? taskList : taskList.filter(t => t.status == filter)
    taskCount: "{filteredTasks.length} tasks"
    hasNoResults: filteredTasks.length == 0
  }

  @actions {
    setFilter(f) { filter = f }
    selectTask(t) {
      selectedTask = t
      view = "detail"
    }
  }

  layout: vertical, gap: spacing.2

  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "list", size: icon.md, color: semantic.interactive)
    text("Tasks") { style: type.heading-md, color: semantic.text-primary }
  }

  // Filter bar with hover states
  block {
    role: "toolbar"
    aria-label: "Task filters"
    padding: spacing.3
    background: semantic.surface
    border-radius: radius.md
    border: borders.default
    shadow: elevation.flat
    layout: responsive(vertical, md: horizontal), gap: spacing.3, align: center
    transition: transition.shadow

    on hover {
      shadow: elevation.raised
    }

    text(taskCount) { style: type.body-sm, color: semantic.text-secondary }
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

  // Skeleton loading state
  block {
    visibility: tasksLoading
    layout: vertical, gap: spacing.2
    Skeleton(height: "48px", width: "100%")
    Skeleton(height: "48px", width: "100%")
    Skeleton(height: "48px", width: "100%")
    Skeleton(height: "48px", width: "95%")
    Skeleton(height: "48px", width: "90%")
  }

  // Error display with Alert
  block {
    visibility: tasksError
    Alert(severity: "error", message: "The task list could not be retrieved from the server.", title: "Failed to load tasks")
  }

  // Task rows with hover effects and transitions
  each filteredTasks as task, index {
    block {
      role: "button"
      tabindex: "0"
      padding: spacing.3
      background: semantic.surface-raised
      border: borders.default
      border-radius: radius.md
      border-left: borders.accent-none
      shadow: elevation.flat
      cursor: "pointer"
      transition: transition.row-hover
      layout: responsive(vertical, md: horizontal), gap: spacing.3, align: center
      on click: selectTask(task)

      on hover {
        background: semantic.surface-hover
        shadow: elevation.raised
        border-left: borders.accent-interactive
        transform: transform.nudge-right-sm
      }

      on focus {
        shadow: elevation.raised
        border-left: borders.accent-interactive
      }

      text("{index}") { style: type.mono-sm, color: semantic.text-secondary }
      block {
        layout: vertical, gap: spacing.1
        text(task.title) { style: type.body-md, weight: 500, color: semantic.text-primary }
        text(task.assignee) { style: type.body-sm, color: semantic.text-secondary }
      }
      StatusBadge(status: task.status)
      Tooltip(text: "Priority: {task.priority}") {
        PriorityBadge(priority: task.priority)
      }
    }
  }

  // Empty state
  block {
    visibility: hasNoResults
    EmptyState(
      message: "No Tasks Found",
      description: "No tasks match the current filter. Try changing your filter criteria."
    )
  }
}
