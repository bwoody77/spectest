// TaskDetail — detail view with Image, StatusBadge, PriorityBadge, Modal

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

    detailBg: match themePreset { "enterprise" -> "#e2e8f0", "social" -> "#ede9fe", "minimal" -> "#f5f5f5", "playful" -> "#ffedd5", _ -> "#e2e8f0" }
    detailBorder: match themePreset { "enterprise" -> "1px solid #94a3b8", "social" -> "1px solid #a78bfa", "minimal" -> "1px solid #d4d4d4", "playful" -> "1px solid #fb923c", _ -> "1px solid #94a3b8" }
    padOuter: match themePreset { "enterprise" -> "8px 12px", "social" -> "16px", "minimal" -> "24px 32px", "playful" -> "20px", _ -> "16px" }
    padInner: match themePreset { "enterprise" -> "6px 10px", "social" -> "12px", "minimal" -> "20px", "playful" -> "16px", _ -> "12px" }
    cardRadius: match themePreset { "enterprise" -> "2px", "social" -> "20px", "minimal" -> "0px", "playful" -> "16px", _ -> "8px" }
    cardGap: match themePreset { "enterprise" -> "6px", "social" -> "12px", "minimal" -> "20px", "playful" -> "14px", _ -> "12px" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }
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

  text("Task Detail") { style: type.heading-lg, color: textPrimary }

  block {
    visibility: !hasTask
    padding: padOuter
    background: detailBg
    border-radius: cardRadius
    layout: vertical, gap: cardGap, align: center
    Icon(name: "info", size: "24px", color: textMuted)
    text("Select a task to view details.") { style: type.body-sm, color: textMuted }
  }

  block {
    visibility: hasTask
    layout: vertical, gap: cardGap

    text(detailHeading) { style: type.heading-md, color: textPrimary }

    Image(src: "https://via.placeholder.com/64", alt: "Placeholder thumbnail for the selected task", width: 64, height: 64)

    block {
      layout: horizontal, gap: cardGap
      block {
        padding: padInner
        background: detailBg
        border-radius: cardRadius
        layout: vertical, gap: cardGap
        text("Status") { style: type.label-sm, color: textMuted }
        StatusBadge(taskStatus)
      }
      block {
        padding: padInner
        background: detailBg
        border-radius: cardRadius
        layout: vertical, gap: cardGap
        text("Priority") { style: type.label-sm, color: textMuted }
        PriorityBadge(taskPriority)
      }
      block {
        padding: padInner
        background: detailBg
        border-radius: cardRadius
        layout: vertical, gap: cardGap
        text("Assignee") { style: type.label-sm, color: textMuted }
        text(taskAssignee) { style: type.body-md, color: textPrimary }
      }
      block {
        padding: padInner
        background: detailBg
        border-radius: cardRadius
        layout: vertical, gap: cardGap
        text("Created") { style: type.label-sm, color: textMuted }
        text(taskDate) { style: type.body-md, color: textPrimary }
      }
    }

    block {
      layout: horizontal, gap: cardGap
      Button(label: "Back", variant: "secondary") {
        on click: goBack()
      }
      Button(label: "Delete Task", variant: "primary") {
        on click: showDeleteConfirm()
      }
    }

    // Delete confirmation modal
    Modal(title: "Confirm Delete", open: confirmingDelete) {
      on close: cancelDelete()
      text("Are you sure you want to delete this task? This action cannot be undone.") { style: type.body-md, color: textPrimary }
      block {
        layout: horizontal, gap: cardGap
        Button(label: "Cancel", variant: "secondary") {
          on click: cancelDelete()
        }
        Button(label: "Delete", variant: "primary") {
          on click: confirmDelete()
        }
      }
    }
  }
}
