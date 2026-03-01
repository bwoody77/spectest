// TaskDetail — Enhanced for Gate #22
// Uses: ConfirmDialog (Issue #19), Card (Issue #17), Badge (Issue #17),
//   backdrop-blur (Issue #57), transitions (Issue #52), shadows (Issue #54),
//   positioned layout (Issue #50), hover states (Issue #53), grid (Issue #51)

surface TaskDetail(task, view) {
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

  layout: vertical, gap: spacing.3

  // Header
  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "eye", size: icon.md, color: semantic.interactive)
    text("Task Detail") { style: type.heading-lg, color: semantic.text-primary, letter-spacing: "-0.01em" }
  }

  // Empty state when no task selected
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
    layout: vertical, gap: spacing.3

    // Title with left border accent
    block {
      padding: spacing.4
      border-left: borders.accent-interactive-strong
      background: semantic.surface
      border-radius: radius.md
      text(detailHeading) { style: type.heading-md, color: semantic.text-primary }
    }

    Image(src: "https://via.placeholder.com/64", alt: "Task thumbnail")

    // Detail grid using CSS Grid and Cards
    block {
      layout: grid, columns: responsive("1fr 1fr", lg: "1fr 1fr 1fr 1fr"), gap: spacing.3

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.2
          transition: transition.subtle
          on hover {
            transform: transform.lift-xs
          }
          text("Status") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          StatusBadge(taskStatus)
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.2
          transition: transition.subtle
          on hover {
            transform: transform.lift-xs
          }
          text("Priority") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          PriorityBadge(taskPriority)
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.2
          transition: transition.subtle
          on hover {
            transform: transform.lift-xs
          }
          text("Assignee") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(taskAssignee) { style: type.body-md, weight: 600, color: semantic.text-primary }
        }
      }

      Card() {
        block {
          padding: spacing.3
          layout: vertical, gap: spacing.2
          transition: transition.subtle
          on hover {
            transform: transform.lift-xs
          }
          text("Created") { style: type.label-sm, color: semantic.text-secondary, text-transform: "uppercase", letter-spacing: "0.05em" }
          text(taskDate) { style: type.mono-md, color: semantic.text-primary }
        }
      }
    }

    // Action buttons
    block {
      layout: horizontal, gap: spacing.3
      Button(label: "Back to Dashboard", variant: "secondary") {
        on click: goBack()
      }
      Button(label: "Delete Task", variant: "destructive") {
        on click: showDeleteConfirm()
      }
    }

    // Delete confirmation with ConfirmDialog
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
