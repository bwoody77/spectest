// Wizard surfaces — Enhanced for Gate #22
// Uses: Stepper (Issue #18), Card (Issue #17), Alert (Issue #19),
//   transitions (Issue #52), hover states (Issue #53), text styling (Issue #55)

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

  // Step header
  text("Step 1: Basic Info") { style: type.heading-md, letter-spacing: "-0.01em" }
  text("Provide the core details for this task.") { style: type.body-sm, color: semantic.text-secondary }

  Card() {
    block {
      padding: spacing.4
      layout: vertical, gap: spacing.4

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
    }
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

  text("Step 2: Options") { style: type.heading-md, letter-spacing: "-0.01em" }
  text("Configure priority, deadline, and assignment options.") { style: type.body-sm, color: semantic.text-secondary }

  Card() {
    block {
      padding: spacing.4
      layout: vertical, gap: spacing.4

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
    }
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

  text("Step 3: Review & Confirm") { style: type.heading-md, letter-spacing: "-0.01em" }
  text("Please review your task details and confirm submission.") { style: type.body-sm, color: semantic.text-secondary }

  // Info alert (Issue #19)
  Alert(severity: "info", message: "All fields can be edited after creation.", title: "Editable Later")

  Card() {
    block {
      padding: spacing.4
      layout: vertical, gap: spacing.3

      Checkbox(label: "I confirm this task is correct", checked: confirmed) {
        on change(v): { confirmed = v }
      }
    }
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
  layout: vertical, gap: spacing.5, align: center

  // Success with icon
  block {
    padding: spacing.6
    background: gradient.stat-success-subtle
    border-radius: radius.lg
    shadow: elevation.raised
    layout: vertical, gap: spacing.4, align: center

    Icon(name: "check", size: icon.xxl, color: semantic.success)
    text("Task Created!") { style: type.heading-lg, color: semantic.success-text, letter-spacing: "-0.02em" }
    text("Your task has been successfully submitted.") { style: type.body-md, color: semantic.success-mid }
  }

  block {
    layout: horizontal, gap: spacing.3, justify: center
    Button(label: "Create Another", variant: "primary") {
      on click: dispatch("restart")
    }
  }
}

// Stepper indicator surface (Issue #18)
surface WizardStepper(currentStep) {
  Stepper(
    steps: [
      {id: "info", label: "Basic Info", description: "Title & assignee"},
      {id: "options", label: "Options", description: "Priority & dates"},
      {id: "review", label: "Review", description: "Confirm details"},
      {id: "done", label: "Done", description: "Task created"}
    ],
    activeStep: currentStep,
    orientation: "horizontal"
  )
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
