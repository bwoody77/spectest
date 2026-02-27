// ---------------------------------------------------------------------------
// Gate #16 — Admin Dashboard
// Exercises: sources, flows, forms, each, visibility, computed, actions,
//            multi-surface composition, theme switching, Input, Select,
//            DatePicker, Button, Toggle, Checkbox, Icon, Image,
//            form validation, template strings, pipes, match expressions,
//            guarded flow transitions, component declarations
// ---------------------------------------------------------------------------

@visual-system {
  spacing: 4px-unit
  type-scale: 1.25-ratio, base 14px
  palette: slate(neutral), indigo(primary), red(danger), emerald(success), amber(warning)
  radius: 6px(sm), 8px(md), 12px(lg), 9999px(full)
  motion: 150ms ease(default), 300ms ease(slow)
}

// Data sources

source TasksAPI {
  endpoint: "http://localhost:4000/api/tasks"
  method: GET
  cache: 1
}

source StatsAPI {
  endpoint: "http://localhost:4000/api/stats"
  method: GET
  cache: 1
}

source UsersAPI {
  endpoint: "http://localhost:4000/api/users"
  method: GET
  cache: 5
}

// ---------------------------------------------------------------------------
// Component: StatusBadge — match expression for status
// ---------------------------------------------------------------------------

component StatusBadge(status: string) {
  text(match status {
    "todo" -> "Todo",
    "in-progress" -> "In Progress",
    "done" -> "Done",
    _ -> "Unknown"
  }) { style: type.label-sm }
}

// ---------------------------------------------------------------------------
// Component: PriorityBadge — match expression for priority
// ---------------------------------------------------------------------------

component PriorityBadge(priority: string) {
  text(match priority {
    "low" -> "Low",
    "medium" -> "Medium",
    "high" -> "High",
    "critical" -> "Critical",
    _ -> "—"
  }) { style: type.label-sm }
}

// ---------------------------------------------------------------------------
// Surface: StatsBar — metric cards with Icon + template strings
// ---------------------------------------------------------------------------

surface StatsBar(total, done, inProgress, todo) {
  layout: horizontal, gap: spacing.4, align: center

  block {
    padding: spacing.3
    background: "#eef2ff"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "list", size: "18px", color: "#6366f1")
    text("Total: {total}") { style: type.label-md }
  }
  block {
    padding: spacing.3
    background: "#ecfdf5"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "check", size: "18px", color: "#10b981")
    text("Done: {done}") { style: type.label-md }
  }
  block {
    padding: spacing.3
    background: "#fffbeb"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "loader", size: "18px", color: "#f59e0b")
    text("In Progress: {inProgress}") { style: type.label-md }
  }
  block {
    padding: spacing.3
    background: "#f8fafc"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "circle", size: "18px", color: "#94a3b8")
    text("Todo: {todo}") { style: type.label-md }
  }
}

// ---------------------------------------------------------------------------
// Surface: TaskTable — filterable list with Buttons, each+index, components
// ---------------------------------------------------------------------------

surface TaskTable {
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
  }

  @actions {
    setFilter(f) { filter = f }
  }

  layout: vertical, gap: spacing.4

  text("Tasks") { style: type.heading-md }

  // Filter bar
  block {
    padding: spacing.3
    background: "#f8fafc"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    text(taskCount) { style: type.body-sm, color: "#64748b" }
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
    visibility: tasksLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    text("Loading tasks...") { style: type.body-sm, color: "#64748b" }
  }

  // Error display
  block {
    visibility: tasksError
    padding: spacing.3
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: radius.md
    text("Failed to load tasks.") { style: type.body-sm, color: "red" }
  }

  // Task rows
  each filteredTasks as task, index {
    block {
      padding: spacing.3
      background: "#ffffff"
      border: "1px solid #e2e8f0"
      border-radius: radius.md
      layout: horizontal, gap: spacing.4, align: center
      text("{index}") { style: type.mono-sm, color: "#94a3b8" }
      block {
        layout: vertical, gap: spacing.1
        text(task.title) { style: type.body-md, weight: 500 }
        text(task.assignee) { style: type.body-sm, color: "#64748b" }
      }
      StatusBadge(task.status)
      PriorityBadge(task.priority)
    }
  }

  // Empty state
  block {
    visibility: hasNoResults
    padding: spacing.4
    background: "#f8fafc"
    border-radius: radius.md
    text("No tasks match the current filter.") { style: type.body-sm, color: "#64748b" }
  }
}

// ---------------------------------------------------------------------------
// Surface: TaskForm — form validation with Input, Select, DatePicker,
//          Checkbox, Button, visibility, computed errors, template strings
// ---------------------------------------------------------------------------

surface TaskForm {
  @state {
    title: ""
    assignee: ""
    priority: "medium"
    status: "todo"
    dueDate: null
    notes: ""
    urgent: false
    submitted: false
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
    formSummary: "Creating task: {title}"
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
    setError(e) { error = e }
    submitForm() {
      touched = true
      if isValid {
        fetch("http://localhost:4000/api/tasks", {method: "POST", body: JSON.stringify({title: title, assignee: assignee, priority: priority, status: status})})
        submitted = true
        error = ""
      }
    }
    dismissSuccess() {
      submitted = false
    }
  }

  layout: vertical, gap: spacing.5

  text("Create New Task") { style: type.heading-lg }

  // Success banner (shown above the form, dismissible)
  block {
    visibility: successVisible
    padding: spacing.3
    background: "#ecfdf5"
    border: "1px solid #bbf7d0"
    border-radius: radius.md
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "check", size: "20px", color: "#10b981")
    text("Task created successfully!") { style: type.body-md, color: "#10b981" }
    Button(label: "Dismiss", variant: "ghost") {
      on click: dismissSuccess()
    }
  }

  // Form (always visible so inputs retain their DOM state)
  block {
    layout: vertical, gap: spacing.4

    text(formSummary) { style: type.body-sm }

    // Title
    block {
      layout: vertical, gap: spacing.1
      Input(type: "text", label: "Title", value: title, placeholder: "Enter task title", error: hasTitleError) {
        on change(v): { title = v }
      }
      block {
        visibility: hasTitleError
        text(titleError) { style: type.body-sm, color: "red" }
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
          visibility: hasAssigneeError
          text(assigneeError) { style: type.body-sm, color: "red" }
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
      visibility: hasError
      padding: spacing.3
      background: "#fef2f2"
      border: "1px solid #fecaca"
      border-radius: radius.md
      text(error) { style: type.body-sm, color: "red" }
    }

    // Buttons
    block {
      layout: horizontal, gap: spacing.3
      Button(label: "Create Task", variant: "primary") {
        on click: submitForm()
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Surface: TaskDetail — detail view with Image, StatusBadge, PriorityBadge
// ---------------------------------------------------------------------------

surface TaskDetail {
  @state {
    task: null
  }

  @computed {
    hasTask: task != null
    taskTitle: task != null ? task.title : ""
    taskStatus: task != null ? task.status : ""
    taskAssignee: task != null ? task.assignee : ""
    taskPriority: task != null ? task.priority : ""
    taskDate: task != null ? task.createdAt : ""
    detailHeading: "Task: {taskTitle}"
  }

  @actions {
    setTask(t) { task = t }
  }

  layout: vertical, gap: spacing.4

  text("Task Detail") { style: type.heading-lg }

  block {
    visibility: !hasTask
    padding: spacing.4
    background: "#f8fafc"
    border-radius: radius.md
    layout: vertical, gap: spacing.2, align: center
    Icon(name: "info", size: "24px", color: "#94a3b8")
    text("Select a task to view details.") { style: type.body-sm, color: "#64748b" }
  }

  block {
    visibility: hasTask
    layout: vertical, gap: spacing.4

    text(detailHeading) { style: type.heading-md }

    Image(src: "https://via.placeholder.com/64", alt: "Task icon", width: 64, height: 64)

    block {
      layout: horizontal, gap: spacing.4
      block {
        padding: spacing.3
        background: "#f8fafc"
        border-radius: radius.md
        layout: vertical, gap: spacing.1
        text("Status") { style: type.label-sm, color: "#64748b" }
        StatusBadge(taskStatus)
      }
      block {
        padding: spacing.3
        background: "#f8fafc"
        border-radius: radius.md
        layout: vertical, gap: spacing.1
        text("Priority") { style: type.label-sm, color: "#64748b" }
        PriorityBadge(taskPriority)
      }
      block {
        padding: spacing.3
        background: "#f8fafc"
        border-radius: radius.md
        layout: vertical, gap: spacing.1
        text("Assignee") { style: type.label-sm, color: "#64748b" }
        text(taskAssignee) { style: type.body-md }
      }
      block {
        padding: spacing.3
        background: "#f8fafc"
        border-radius: radius.md
        layout: vertical, gap: spacing.1
        text("Created") { style: type.label-sm, color: "#64748b" }
        text(taskDate) { style: type.body-md }
      }
    }

    Button(label: "Back", variant: "secondary") {
      on click: setTask(null)
    }
  }
}

// ---------------------------------------------------------------------------
// Wizard surfaces — multi-step task creation
// ---------------------------------------------------------------------------

surface WizardStep1 {
  @state {
    title: ""
    assignee: ""
  }

  @computed {
    titleFilled: title != ""
  }

  @actions {
    setTitle(v) { title = v }
    setAssignee(v) { assignee = v }
  }

  layout: vertical, gap: spacing.5

  text("Step 1: Basic Info") { style: type.heading-md }
  text("Provide the core details for this task.") { style: type.body-sm }

  Input(type: "text", label: "Title", value: title, placeholder: "Task title") {
    on change(v): { title = v }
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
    Button(label: "Next", variant: "primary")
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
    Button(label: "Back", variant: "ghost")
    Button(label: "Next", variant: "primary")
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
    Button(label: "Back", variant: "ghost")
    Button(label: "Submit", variant: "primary", disabled: !confirmed)
  }
}

// ---------------------------------------------------------------------------
// Flow: TaskWizard — multi-step wizard with guards
// ---------------------------------------------------------------------------

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
    surface: WizardStep3
    on restart -> Info
  }
}

// ---------------------------------------------------------------------------
// Surface: App — main shell (auto-mounted by dev server)
// ---------------------------------------------------------------------------

surface App {
  @state {
    theme: "light"
    view: "dashboard"
  }

  @source {
    stats: StatsAPI
  }

  @computed {
    themeLabel: theme == "light" ? "Dark Mode" : "Light Mode"
    showDashboard: view == "dashboard"
    showDetail: view == "detail"
    showCreate: view == "create"
    showWizard: view == "wizard"
    viewTitle: match view {
      "dashboard" -> "Dashboard",
      "detail" -> "Task Detail",
      "create" -> "Create Task",
      "wizard" -> "Task Wizard",
      _ -> "Admin"
    }
    statsTotal: stats != null ? stats.total : 0
    statsDone: stats != null ? stats.done : 0
    statsInProgress: stats != null ? stats.inProgress : 0
    statsTodo: stats != null ? stats.todo : 0
  }

  @actions {
    toggleTheme() { theme = theme == "light" ? "dark" : "light" }
    setView(v) { view = v }
  }

  layout: vertical, gap: spacing.6

  // Header
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: horizontal, gap: spacing.4, align: center, justify: between

    block {
      layout: horizontal, gap: spacing.3, align: center
      Icon(name: "home", size: "22px", color: "#6366f1")
      text(viewTitle) { style: type.heading-lg }
    }

    block {
      layout: horizontal, gap: spacing.3, align: center
      Toggle(checked: theme == "dark", label: themeLabel) {
        on change: toggleTheme()
      }
    }
  }

  // Navigation tabs
  Tabs(
    tabs: [
      {id: "dashboard", label: "Dashboard"},
      {id: "detail", label: "Detail"},
      {id: "create", label: "New Task"},
      {id: "wizard", label: "Wizard"}
    ],
    activeTab: view
  ) {
    on change(v): { view = v }
  }

  // Dashboard view
  block {
    visibility: showDashboard
    layout: vertical, gap: spacing.6
    StatsBar(statsTotal, statsDone, statsInProgress, statsTodo)
    TaskTable()
  }

  // Detail view
  block {
    visibility: showDetail
    TaskDetail()
  }

  // Create view
  block {
    visibility: showCreate
    TaskForm()
  }

  // Wizard view
  block {
    visibility: showWizard
    TaskWizard()
  }
}
