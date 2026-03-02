// TaskForm — Enhanced for Gate #22
// Uses: Alert (Issue #19), Progress (Issue #19), hover/focus states (Issue #53),
//   transitions (Issue #52), shadows (Issue #54), individual borders (Issue #56)

surface TaskForm() {
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

  layout: vertical, gap: spacing.3

  // Header
  block {
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "plus", size: icon.md, color: semantic.interactive)
    text("Create New Task") { style: type.heading-lg, color: semantic.text-primary, letter-spacing: "-0.01em" }
    Popover(placement: "bottom", openOn: "click", text: "Fill in the required fields (Title and Assignee) then click Create Task.") {
      Icon(name: "info", size: icon.sm, color: semantic.text-secondary)
    }
  }

  text(formSummary) { style: type.body-sm, color: semantic.text-secondary }

  // Success Alert
  block {
    visibility: successVisible
    Alert(severity: "success", message: "Your new task has been added to the backlog.", title: "Task created!", dismissible: true) {
      on dismiss: dismissSuccess()
    }
  }

  // Error Alert
  block {
    visibility: hasError
    Alert(severity: "error", message: error, title: "Submission failed")
  }

  // Form card with shadow and hover
  Card() {
    block {
      padding: spacing.5
      layout: vertical, gap: spacing.4
      transition: transition.shadow-slow

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

      // Assignee + Priority (side by side with responsive grid)
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

      // Submitting progress
      block {
        visibility: isSubmitting
        layout: horizontal, gap: spacing.3, align: center
        padding: spacing.3
        background: semantic.info-bg
        border-radius: radius.md
        border-left: borders.accent-interactive
        Progress(value: 75, label: "Submitting...")
      }

      // Submit buttons
      block {
        layout: responsive(vertical, md: horizontal), gap: spacing.3
        Button(label: "Create Task", variant: "primary") {
          on click: submitForm()
        }
        Button(label: "Reset", variant: "ghost")
      }
    }
  }
}
