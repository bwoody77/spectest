// TaskDetail — Enhanced for Gate #22
// Uses: ConfirmDialog (Issue #19), Card (Issue #17), Badge (Issue #17),
//   backdrop-blur (Issue #57), transitions (Issue #52), shadows (Issue #54),
//   positioned layout (Issue #50), hover states (Issue #53), grid (Issue #51)

surface TaskDetail(themePreset, task, view) {
  @state {
    confirmingDelete: false
  }

  @computed {
    hasTask: task != null
    taskTitle: task != null ? task.title : ""
    taskStatus: task != null ? task.status : ""
    taskAssignee: task != null ? task.assignee : ""
    taskPriority: task != null ? task.priority : ""
    taskDate: task != null ? task.createdAt : ""
    taskId: task != null ? task.id : ""
    detailHeading: "Task: {taskTitle}"

    accentColor: match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    cardRadius: match themePreset { "enterprise" -> "4px", "social" -> "16px", "minimal" -> "0px", "playful" -> "12px", _ -> "8px" }
    cardGap: match themePreset { "enterprise" -> "8px", "social" -> "14px", "minimal" -> "20px", "playful" -> "12px", _ -> "12px" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }
    surfaceBg: match themePreset { "enterprise" -> "#f8fafc", "social" -> "#faf5ff", "minimal" -> "#fafafa", "playful" -> "#fffbf5", _ -> "#f8fafc" }
  }

  @actions {
    goBack() {
      task = null
      view = "dashboard"
    }
    showDeleteConfirm() {
      confirmingDelete = true
    }
    cancelDelete() {
      confirmingDelete = false
    }
    confirmDelete() {
      await fetch("http://localhost:4000/api/tasks/" + taskId, {method: "DELETE"})
      confirmingDelete = false
      task = null
      view = "dashboard"
    }
  }

  layout: vertical, gap: cardGap

  // Header
  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "eye", size: "20px", color: accentColor)
    text("Task Detail") { style: type.heading-lg, color: textPrimary, letter-spacing: "-0.01em" }
  }

  // Empty state when no task selected (Issue #17)
  block {
    visibility: !hasTask
    EmptyState(
      message: "No Task Selected",
      description: "Select a task from the Dashboard to view its details here."
    )
  }

  // Task detail content
  block {
    visibility: hasTask
    layout: vertical, gap: cardGap

    // Title with left border accent (Issue #56)
    block {
      padding: spacing.4
      border-left: "4px solid {accentColor}"
      background: surfaceBg
      border-radius: cardRadius
      text(detailHeading) { style: type.heading-md, color: textPrimary }
    }

    Image(src: "https://via.placeholder.com/64", alt: "Task thumbnail")

    // Detail grid using CSS Grid (Issue #51) and Cards (Issue #17)
    block {
      layout: grid, columns: responsive("1fr 1fr", lg: "1fr 1fr 1fr 1fr"), gap: cardGap

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.2
          transition: "transform 150ms ease"
          on hover {
            transform: "translateY(-1px)"
          }
          text("Status") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
          StatusBadge(taskStatus)
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.2
          transition: "transform 150ms ease"
          on hover {
            transform: "translateY(-1px)"
          }
          text("Priority") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
          PriorityBadge(taskPriority)
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.2
          transition: "transform 150ms ease"
          on hover {
            transform: "translateY(-1px)"
          }
          text("Assignee") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(taskAssignee) { style: type.body-md, weight: 600, color: textPrimary }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.2
          transition: "transform 150ms ease"
          on hover {
            transform: "translateY(-1px)"
          }
          text("Created") { style: type.label-sm, color: textMuted, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(taskDate) { style: type.mono-md, color: textPrimary }
        }
      }
    }

    // Action buttons
    block {
      layout: horizontal, gap: cardGap
      Button(label: "Back to Dashboard", variant: "secondary") {
        on click: goBack()
      }
      Button(label: "Delete Task", variant: "destructive") {
        on click: showDeleteConfirm()
      }
    }

    // Delete confirmation with ConfirmDialog (Issue #19)
    ConfirmDialog(
      open: confirmingDelete,
      title: "Delete Task",
      message: "Are you sure you want to delete this task? This action cannot be undone.",
      confirmLabel: "Delete",
      cancelLabel: "Cancel",
      destructive: true
    ) {
      on confirm: confirmDelete()
      on cancel: cancelDelete()
    }
  }
}
