// Wizard surfaces — multi-step task creation

surface WizardStep1 {
  @state {
    title: ""
    assignee: ""
    titleTouched: false
  }

  @computed {
    titleFilled: title != ""
    showTitleError: titleTouched && title == ""
  }

  @actions {
    setTitle(v) { title = v }
    setAssignee(v) { assignee = v }
  }

  layout: vertical, gap: spacing.5

  text("Step 1: Basic Info") { style: type.heading-md }
  text("Provide the core details for this task.") { style: type.body-sm }

  block {
    layout: vertical, gap: spacing.1
    Input(type: "text", label: "Title", value: title, placeholder: "Task title", error: showTitleError) {
      on change(v): {
        title = v
        titleTouched = true
      }
    }
    block {
      aria-live: "polite"
      visibility: showTitleError
      text("Title is required") { style: type.body-sm, color: palette.danger.500 }
    }
  }

  Select(
    options: [
      {value: "alice", label: "Alice"},
      {value: "bob", label: "Bob"},
      {value: "carol", label: "Carol"}
    ],
    value: assignee,
    placeholder: "Choose assignee",
    label: "Assignee"
  ) {
    on change(v): { assignee = v }
  }

  block {
    layout: horizontal, gap: spacing.3, justify: end
    Button(label: "Next", variant: "primary", disabled: !titleFilled) {
      on click: dispatch("next")
    }
  }
}

surface WizardStep2 {
  @state {
    priority: "medium"
    dueDate: null
    autoAssign: false
  }

  @actions {
    setPriority(v) { priority = v }
    setDueDate(v) { dueDate = v }
    setAutoAssign(v) { autoAssign = v }
  }

  layout: vertical, gap: spacing.5

  text("Step 2: Options") { style: type.heading-md }
  text("Configure priority, deadline, and assignment options.") { style: type.body-sm }

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

  DatePicker(value: dueDate, label: "Due Date", placeholder: "Select deadline") {
    on change(v): { dueDate = v }
  }

  Toggle(checked: autoAssign, label: "Auto-assign reviewer") {
    on change(v): { autoAssign = v }
  }

  block {
    layout: horizontal, gap: spacing.3, justify: end
    Button(label: "Back", variant: "ghost") {
      on click: dispatch("back")
    }
    Button(label: "Next", variant: "primary") {
      on click: dispatch("next")
    }
  }
}

surface WizardStep3 {
  @state {
    confirmed: false
  }

  @actions {
    setConfirmed(v) { confirmed = v }
  }

  layout: vertical, gap: spacing.5

  text("Step 3: Review & Confirm") { style: type.heading-md }
  text("Please review your task details and confirm submission.") { style: type.body-sm }

  block {
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "info", size: "18px", color: "#6366f1")
    text("All fields can be edited later.") { style: type.body-sm }
  }

  Checkbox(label: "I confirm this task is correct", checked: confirmed) {
    on change(v): { confirmed = v }
  }

  block {
    layout: horizontal, gap: spacing.3, justify: end
    Button(label: "Back", variant: "ghost") {
      on click: dispatch("back")
    }
    Button(label: "Submit", variant: "primary", disabled: !confirmed) {
      on click: dispatch("submit")
    }
  }
}

surface WizardDone {
  layout: vertical, gap: spacing.5
  text("Task Created!") { style: type.heading-md }
  text("Your task has been successfully submitted.") { style: type.body-sm }
  block {
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "check-circle", size: "18px", color: "#10b981")
    text("All done. You can create another task or return to the dashboard.") { style: type.body-sm }
  }
  block {
    layout: horizontal, gap: spacing.3, justify: end
    Button(label: "Create Another", variant: "primary") {
      on click: dispatch("restart")
    }
  }
}

// Flow: TaskWizard — multi-step wizard with guards

flow TaskWizard {
  state Info {
    surface: WizardStep1
    on next [guard: title != ""] -> Options
  }
  state Options {
    surface: WizardStep2
    on back -> Info
    on next -> Review
  }
  state Review {
    surface: WizardStep3
    on back -> Options
    on submit [guard: confirmed] -> Done
  }
  state Done {
    surface: WizardDone
    on restart -> Info
  }
}
