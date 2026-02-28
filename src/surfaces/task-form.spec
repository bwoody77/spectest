// TaskForm — form validation with Input, Select, DatePicker, Checkbox, Button, Popover

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
    formSummary: "Creating task: {title}"
    successVisible: submitted

    formBg: match themePreset { "enterprise" -> "#e2e8f0", "social" -> "#ede9fe", "minimal" -> "#f5f5f5", "playful" -> "#ffedd5", _ -> "#e2e8f0" }
    formBorder: match themePreset { "enterprise" -> "1px solid #94a3b8", "social" -> "1px solid #a78bfa", "minimal" -> "1px solid #d4d4d4", "playful" -> "1px solid #fb923c", _ -> "1px solid #94a3b8" }
    padOuter: match themePreset { "enterprise" -> "8px 12px", "social" -> "16px", "minimal" -> "24px 32px", "playful" -> "20px", _ -> "16px" }
    padInner: match themePreset { "enterprise" -> "6px 10px", "social" -> "12px", "minimal" -> "20px", "playful" -> "16px", _ -> "12px" }
    cardRadius: match themePreset { "enterprise" -> "2px", "social" -> "20px", "minimal" -> "0px", "playful" -> "16px", _ -> "8px" }
    cardGap: match themePreset { "enterprise" -> "6px", "social" -> "12px", "minimal" -> "20px", "playful" -> "14px", _ -> "12px" }
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
    setError(e) { error = e }
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

  block {
    layout: horizontal, gap: spacing.2, align: center
    text("Create New Task") { style: type.heading-lg, color: textPrimary }
    Popover(placement: "bottom", openOn: "click", text: "Fill in the required fields (Title and Assignee) then click Create Task. Priority defaults to Medium.") {
      Icon(name: "info", size: "18px", color: textMuted)
    }
  }

  // Success banner (shown above the form, dismissible)
  block {
    aria-live: "polite"
    visibility: successVisible
    padding: padInner
    background: "#ecfdf5"
    border: "1px solid #bbf7d0"
    border-radius: cardRadius
    layout: horizontal, gap: cardGap, align: center
    Icon(name: "check", size: "20px", color: "#10b981")
    text("Task created successfully!") { style: type.body-md, color: palette.success.500 }
    Button(label: "Dismiss", variant: "ghost") {
      on click: dismissSuccess()
    }
  }

  // Form (always visible so inputs retain their DOM state)
  block {
    layout: vertical, gap: cardGap

    text(formSummary) { style: type.body-sm, color: textMuted }

    // Title
    block {
      layout: vertical, gap: spacing.1
      Input(type: "text", label: "Title", value: title, placeholder: "Enter task title", error: hasTitleError) {
        on change(v): { title = v }
      }
      block {
        aria-live: "polite"
        visibility: hasTitleError
        text(titleError) { style: type.body-sm, color: palette.danger.500 }
      }
    }

    // Notes
    Input(type: "textarea", label: "Notes", value: notes, placeholder: "Optional notes...") {
      on change(v): { notes = v }
    }

    // Assignee + Priority (side by side)
    block {
      layout: horizontal, gap: spacing.4

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
          aria-live: "polite"
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

    // Status + Due Date (side by side)
    block {
      layout: horizontal, gap: spacing.4

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

    // Error display
    block {
      aria-live: "polite"
      visibility: hasError
      padding: padInner
      background: "#fef2f2"
      border: "1px solid #fecaca"
      border-radius: cardRadius
      text(error) { style: type.body-sm, color: palette.danger.500 }
    }

    // Submitting indicator
    block {
      aria-live: "polite"
      visibility: isSubmitting
      padding: padInner
      background: "#eff6ff"
      border: "1px solid #bfdbfe"
      border-radius: cardRadius
      layout: horizontal, gap: cardGap, align: center
      Icon(name: "loader", size: "16px", color: "#3b82f6")
      text("Submitting...") { style: type.body-sm, color: "#3b82f6" }
    }

    // Buttons
    block {
      layout: horizontal, gap: cardGap
      Button(label: "Create Task", variant: "primary") {
        on click: submitForm()
      }
    }
  }
}
