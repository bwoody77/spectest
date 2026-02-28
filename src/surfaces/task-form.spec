// TaskForm — Enhanced for Gate #22
// Uses: Alert (Issue #19), Progress (Issue #19), hover/focus states (Issue #53),
//   transitions (Issue #52), shadows (Issue #54), individual borders (Issue #56)

surface TaskForm(themePreset) {
  @state {
    title: ""
    assignee: ""
    priority: "medium"
    status: "todo"
    dueDate: null
    notes: ""
    urgent: false
    submitted: false
    submitting: false
    error: ""
    touched: false
  }

  @computed {
    titleError: title == "" ? "Title is required" : ""
    assigneeError: assignee == "" ? "Assignee is required" : ""
    hasTitleError: touched && titleError != ""
    hasAssigneeError: touched && assigneeError != ""
    isValid: titleError == "" && assigneeError == ""
    hasError: error != ""
    isSubmitting: submitting
    formSummary: title != "" ? "Creating: {title}" : "Fill in the form below"
    successVisible: submitted

    accentColor: match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    cardRadius: match themePreset { "enterprise" -> "4px", "social" -> "16px", "minimal" -> "0px", "playful" -> "12px", _ -> "8px" }
    cardGap: match themePreset { "enterprise" -> "8px", "social" -> "14px", "minimal" -> "20px", "playful" -> "12px", _ -> "12px" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }
  }

  @actions {
    setTitle(v) {
      title = v
      touched = true
    }
    setAssignee(v) {
      assignee = v
      touched = true
    }
    setPriority(v) { priority = v }
    setStatus(v) { status = v }
    setDueDate(v) { dueDate = v }
    setNotes(v) { notes = v }
    setUrgent(v) { urgent = v }
    submitForm() {
      touched = true
      if isValid {
        submitting = true
        await fetch("http://localhost:4000/api/tasks", {method: "POST", body: JSON.stringify({title: title, assignee: assignee, priority: priority, status: status})})
        submitted = true
        submitting = false
        error = ""
      }
    }
    dismissSuccess() {
      submitted = false
    }
  }

  layout: vertical, gap: cardGap

  // Header
  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "plus", size: "20px", color: accentColor)
    text("Create New Task") { style: type.heading-lg, color: textPrimary, letter-spacing: "-0.01em" }
    Popover(placement: "bottom", openOn: "click", text: "Fill in the required fields (Title and Assignee) then click Create Task.") {
      Icon(name: "info", size: "18px", color: textMuted)
    }
  }

  text(formSummary) { style: type.body-sm, color: textMuted }

  // Success Alert (Issue #19)
  block {
    visibility: successVisible
    Alert(severity: "success", message: "Your new task has been added to the backlog.", title: "Task created!", dismissible: true) {
      on dismiss: dismissSuccess()
    }
  }

  // Error Alert (Issue #19)
  block {
    visibility: hasError
    Alert(severity: "error", message: error, title: "Submission failed")
  }

  // Form card with shadow and hover (Issue #53, #54)
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4
      transition: "shadow 200ms ease"

      on hover {
        shadow: elevation.layered
      }

      // Title
      block {
        layout: vertical, gap: spacing.1
        Input(type: "text", label: "Title", value: title, placeholder: "Enter task title", error: hasTitleError) {
          on change(v): { title = v }
        }
        block {
          visibility: hasTitleError
          text(titleError) { style: type.body-sm, color: palette.danger.500 }
        }
      }

      // Notes
      Input(type: "textarea", label: "Notes", value: notes, placeholder: "Optional notes...") {
        on change(v): { notes = v }
      }

      // Assignee + Priority (side by side with responsive grid, Issue #58)
      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        block {
          layout: vertical, gap: spacing.1
          Select(
            options: [
              {value: "alice", label: "Alice"},
              {value: "bob", label: "Bob"},
              {value: "carol", label: "Carol"}
            ],
            value: assignee,
            placeholder: "Select assignee",
            label: "Assignee",
            error: hasAssigneeError
          ) {
            on change(v): { assignee = v }
          }
          block {
            visibility: hasAssigneeError
            text(assigneeError) { style: type.body-sm, color: palette.danger.500 }
          }
        }

        Select(
          options: [
            {value: "low", label: "Low"},
            {value: "medium", label: "Medium"},
            {value: "high", label: "High"},
            {value: "critical", label: "Critical"}
          ],
          value: priority,
          label: "Priority"
        ) {
          on change(v): { priority = v }
        }
      }

      // Status + Due Date (responsive grid)
      block {
        layout: grid, columns: responsive("1fr", md: "1fr 1fr"), gap: spacing.4

        Select(
          options: [
            {value: "todo", label: "Todo"},
            {value: "in-progress", label: "In Progress"},
            {value: "done", label: "Done"}
          ],
          value: status,
          label: "Status"
        ) {
          on change(v): { status = v }
        }

        DatePicker(value: dueDate, label: "Due Date", placeholder: "Pick a date") {
          on change(v): { dueDate = v }
        }
      }

      // Urgent checkbox
      Checkbox(label: "Mark as urgent", checked: urgent) {
        on change(v): { urgent = v }
      }

      // Submitting progress (Issue #19)
      block {
        visibility: isSubmitting
        layout: horizontal, gap: spacing.3, align: center
        padding: spacing.3
        background: "#eff6ff"
        border-radius: cardRadius
        border-left: "3px solid #3b82f6"
        Progress(value: 75, label: "Submitting...")
      }

      // Submit buttons
      block {
        layout: horizontal, gap: spacing.3
        Button(label: "Create Task", variant: "primary") {
          on click: submitForm()
        }
        Button(label: "Reset", variant: "ghost")
      }
    }
  }
}
