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
  retry: 3
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

source ActivityAPI {
  endpoint: "http://localhost:4000/api/activity"
  method: GET
  cache: 2
}

source NotificationsAPI {
  endpoint: "http://localhost:4000/api/notifications"
  method: GET
  cache: 2
  retry: 2
}

// ---------------------------------------------------------------------------
// Component: StatusBadge — match expression for status
// ---------------------------------------------------------------------------

component StatusBadge(status: string) {
  text(match status {
    "todo" -> "○ Todo",
    "in-progress" -> "◐ In Progress",
    "done" -> "● Done",
    _ -> "Unknown"
  }) { style: type.label-sm }
}

// ---------------------------------------------------------------------------
// Component: PriorityBadge — match expression for priority
// ---------------------------------------------------------------------------

component PriorityBadge(priority: string) {
  text(match priority {
    "low" -> "▽ Low",
    "medium" -> "◇ Medium",
    "high" -> "△ High",
    "critical" -> "▲ Critical",
    _ -> "—"
  }) { style: type.label-sm }
}

// ---------------------------------------------------------------------------
// Component: SeverityBadge — match expression for notification severity
// ---------------------------------------------------------------------------

component SeverityBadge(severity: string) {
  text(match severity {
    "info" -> "ⓘ Info",
    "success" -> "✔ Success",
    "warning" -> "⚠ Warning",
    "error" -> "✖ Error",
    _ -> "Unknown"
  }) { style: type.label-sm }
}

// ---------------------------------------------------------------------------
// Component: ActivityIcon — match expression for activity type
// ---------------------------------------------------------------------------

component ActivityIcon(activityType: string) {
  text(match activityType {
    "task_created" -> "New",
    "task_completed" -> "Done",
    "task_assigned" -> "Assigned",
    "comment" -> "Comment",
    "deploy" -> "Deploy",
    _ -> "Event"
  }) { style: type.label-md }
}

// ---------------------------------------------------------------------------
// Component: UserAvatar — placeholder initials avatar
// ---------------------------------------------------------------------------

component UserAvatar(name: string, bgColor: string) {
  block {
    padding: spacing.2
    background: bgColor
    border-radius: radius.full
    layout: horizontal, align: center, justify: center
    text(name) { style: type.label-md, color: "#ffffff" }
  }
}

// ---------------------------------------------------------------------------
// Surface: StatsBar — metric cards with Icon + template strings
// ---------------------------------------------------------------------------

surface StatsBar(total, done, inProgress, todo, themePreset) {
  @computed {
    stat1Bg: match themePreset { "enterprise" -> "#dbeafe", "social" -> "#ede9fe", "minimal" -> "#f5f5f5", "playful" -> "#ffedd5", _ -> "#dbeafe" }
    stat2Bg: match themePreset { "enterprise" -> "#d1fae5", "social" -> "#e9d5ff", "minimal" -> "#f5f5f5", "playful" -> "#fef08a", _ -> "#d1fae5" }
    stat3Bg: match themePreset { "enterprise" -> "#fef3c7", "social" -> "#fae8ff", "minimal" -> "#f5f5f5", "playful" -> "#fed7aa", _ -> "#fef3c7" }
    stat4Bg: match themePreset { "enterprise" -> "#e2e8f0", "social" -> "#ddd6fe", "minimal" -> "#f5f5f5", "playful" -> "#fecaca", _ -> "#e2e8f0" }
    iconAccent: match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    padInner: match themePreset { "enterprise" -> "6px 10px", "social" -> "12px", "minimal" -> "20px", "playful" -> "16px", _ -> "12px" }
    cardRadius: match themePreset { "enterprise" -> "2px", "social" -> "20px", "minimal" -> "0px", "playful" -> "16px", _ -> "8px" }
    statsGap: match themePreset { "enterprise" -> "8px", "social" -> "16px", "minimal" -> "24px", "playful" -> "16px", _ -> "12px" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
  }

  layout: horizontal, gap: statsGap, align: center

  block {
    padding: padInner
    background: stat1Bg
    border-radius: cardRadius
    layout: horizontal, gap: statsGap, align: center
    Icon(name: "list", size: "18px", color: iconAccent)
    text("Total: {total}") { style: type.label-md, color: textPrimary }
  }
  block {
    padding: padInner
    background: stat2Bg
    border-radius: cardRadius
    layout: horizontal, gap: statsGap, align: center
    Icon(name: "check", size: "18px", color: "#10b981")
    text("Done: {done}") { style: type.label-md, color: textPrimary }
  }
  block {
    padding: padInner
    background: stat3Bg
    border-radius: cardRadius
    layout: horizontal, gap: statsGap, align: center
    Icon(name: "loader", size: "18px", color: "#f59e0b")
    text("In Progress: {inProgress}") { style: type.label-md, color: textPrimary }
  }
  block {
    padding: padInner
    background: stat4Bg
    border-radius: cardRadius
    layout: horizontal, gap: statsGap, align: center
    Icon(name: "circle", size: "18px", color: "#64748b")
    text("Todo: {todo}") { style: type.label-md, color: textPrimary }
  }
}

// ---------------------------------------------------------------------------
// Surface: TaskTable — filterable list with Buttons, each+index, components
// ---------------------------------------------------------------------------

surface TaskTable(themePreset, selectedTask, view) {
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

    surfaceBg: match themePreset { "enterprise" -> "#e2e8f0", "social" -> "#ede9fe", "minimal" -> "#f5f5f5", "playful" -> "#ffedd5", _ -> "#e2e8f0" }
    borderColor: match themePreset { "enterprise" -> "1px solid #94a3b8", "social" -> "1px solid #a78bfa", "minimal" -> "1px solid #d4d4d4", "playful" -> "1px solid #fb923c", _ -> "1px solid #94a3b8" }
    rowBg: match themePreset { "enterprise" -> "#f1f5f9", "social" -> "#f5f3ff", "minimal" -> "#ffffff", "playful" -> "#fff7ed", _ -> "#f1f5f9" }
    padOuter: match themePreset { "enterprise" -> "8px 12px", "social" -> "16px", "minimal" -> "24px 32px", "playful" -> "20px", _ -> "16px" }
    padInner: match themePreset { "enterprise" -> "6px 10px", "social" -> "12px", "minimal" -> "20px", "playful" -> "16px", _ -> "12px" }
    cardRadius: match themePreset { "enterprise" -> "2px", "social" -> "20px", "minimal" -> "0px", "playful" -> "16px", _ -> "8px" }
    cardGap: match themePreset { "enterprise" -> "6px", "social" -> "12px", "minimal" -> "20px", "playful" -> "14px", _ -> "12px" }
    textPrimary: match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }
  }

  @actions {
    setFilter(f) { filter = f }
    selectTask(t) {
      selectedTask = t
      view = "detail"
    }
  }

  layout: vertical, gap: cardGap

  text("Tasks") { style: type.heading-md, color: textPrimary }

  // Filter bar
  block {
    padding: padInner
    background: surfaceBg
    border-radius: cardRadius
    layout: horizontal, gap: cardGap, align: center
    text(taskCount) { style: type.body-sm, color: textMuted }
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
    padding: padOuter
    background: surfaceBg
    border-radius: cardRadius
    text("Loading tasks...") { style: type.body-sm, color: textMuted }
  }

  // Error display
  block {
    visibility: tasksError
    padding: padInner
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: cardRadius
    text("Failed to load tasks.") { style: type.body-sm, color: "red" }
  }

  // Task rows
  each filteredTasks as task, index {
    block {
      padding: padInner
      background: rowBg
      border: borderColor
      border-radius: cardRadius
      layout: horizontal, gap: cardGap, align: center
      on click: selectTask(task)
      text("{index}") { style: type.mono-sm, color: textMuted }
      block {
        layout: vertical, gap: cardGap
        text(task.title) { style: type.body-md, weight: 500, color: textPrimary }
        text(task.assignee) { style: type.body-sm, color: textMuted }
      }
      StatusBadge(task.status)
      PriorityBadge(task.priority)
    }
  }

  // Empty state
  block {
    visibility: hasNoResults
    padding: padOuter
    background: surfaceBg
    border-radius: cardRadius
    text("No tasks match the current filter.") { style: type.body-sm, color: textMuted }
  }
}

// ---------------------------------------------------------------------------
// Surface: TaskForm — form validation with Input, Select, DatePicker,
//          Checkbox, Button, visibility, computed errors, template strings
// ---------------------------------------------------------------------------

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
        fetch("http://localhost:4000/api/tasks", {method: "POST", body: JSON.stringify({title: title, assignee: assignee, priority: priority, status: status})})
        submitted = true
        error = ""
      }
    }
    dismissSuccess() {
      submitted = false
    }
  }

  layout: vertical, gap: cardGap

  text("Create New Task") { style: type.heading-lg, color: textPrimary }

  // Success banner (shown above the form, dismissible)
  block {
    visibility: successVisible
    padding: padInner
    background: "#ecfdf5"
    border: "1px solid #bbf7d0"
    border-radius: cardRadius
    layout: horizontal, gap: cardGap, align: center
    Icon(name: "check", size: "20px", color: "#10b981")
    text("Task created successfully!") { style: type.body-md, color: "#10b981" }
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
      padding: padInner
      background: "#fef2f2"
      border: "1px solid #fecaca"
      border-radius: cardRadius
      text(error) { style: type.body-sm, color: "red" }
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

// ---------------------------------------------------------------------------
// Surface: TaskDetail — detail view with Image, StatusBadge, PriorityBadge
// ---------------------------------------------------------------------------

surface TaskDetail(themePreset, task, view) {
  @computed {
    hasTask: task != null
    taskTitle: task != null ? task.title : ""
    taskStatus: task != null ? task.status : ""
    taskAssignee: task != null ? task.assignee : ""
    taskPriority: task != null ? task.priority : ""
    taskDate: task != null ? task.createdAt : ""
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

    Button(label: "Back", variant: "secondary") {
      on click: goBack()
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
    Button(label: "Next", variant: "primary") {
      on click: dispatch("next", {title: title})
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
      on click: dispatch("submit", {confirmed: confirmed})
    }
  }
}

// ---------------------------------------------------------------------------
// Surface: TeamDirectory — user cards from UsersAPI, avatars, roles
// ---------------------------------------------------------------------------

surface TeamDirectory {
  @source {
    users: UsersAPI
  }

  @state {
    search: ""
    roleFilter: "all"
  }

  @computed {
    userList: users != null ? users : []
    filteredUsers: roleFilter == "all" ? userList : userList.filter(u -> u.role == roleFilter)
    searchResults: filteredUsers
    userCount: "{searchResults.length} members"
    hasNoUsers: searchResults.length == 0
  }

  @actions {
    setSearch(v) { search = v }
    setRoleFilter(v) { roleFilter = v }
  }

  layout: vertical, gap: spacing.5

  text("Team Directory") { style: type.heading-lg }

  // Search & filter bar
  block {
    padding: spacing.3
    background: "#f8fafc"
    border-radius: radius.md
    layout: horizontal, gap: spacing.3, align: center

    Input(type: "text", label: "Search", value: search, placeholder: "Search members...") {
      on change(v): { search = v }
    }

    Select(
      options: [
        {value: "all", label: "All Roles"},
        {value: "admin", label: "Admin"},
        {value: "dev", label: "Developer"},
        {value: "design", label: "Designer"}
      ],
      value: roleFilter,
      label: "Role"
    ) {
      on change(v): { roleFilter = v }
    }

    text(userCount) { style: type.body-sm, color: "#475569" }
  }

  // Loading
  block {
    visibility: usersLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    text("Loading team members...") { style: type.body-sm, color: "#475569" }
  }

  // Error
  block {
    visibility: usersError
    padding: spacing.3
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: radius.md
    text("Failed to load team directory.") { style: type.body-sm, color: "red" }
  }

  // User cards
  block {
    layout: horizontal, gap: spacing.4

    each searchResults as user, idx {
      block {
        padding: spacing.4
        background: "#ffffff"
        border: "1px solid #e2e8f0"
        border-radius: radius.lg
        layout: vertical, gap: spacing.3, align: center

        UserAvatar(user.name, "#6366f1")

        block {
          layout: vertical, gap: spacing.1, align: center
          text(user.name) { style: type.body-md, weight: 600 }
          text(user.role) { style: type.label-sm, color: "#475569" }
          text(user.email) { style: type.body-sm, color: "#475569" }
        }

        block {
          layout: horizontal, gap: spacing.2
          Button(label: "Message", variant: "secondary")
          Button(label: "Profile", variant: "ghost")
        }
      }
    }
  }

  // Empty state
  block {
    visibility: hasNoUsers
    padding: spacing.4
    background: "#f8fafc"
    border-radius: radius.md
    layout: vertical, gap: spacing.2, align: center
    Icon(name: "users", size: "24px", color: "#64748b")
    text("No team members match your criteria.") { style: type.body-sm, color: "#475569" }
  }
}

// ---------------------------------------------------------------------------
// Surface: ActivityFeed — recent activity with icons and timestamps
// ---------------------------------------------------------------------------

surface ActivityFeed {
  @source {
    activityItems: ActivityAPI
  }

  @state {
    typeFilter: "all"
  }

  @computed {
    allActivity: activityItems != null ? activityItems : []
    filteredActivity: typeFilter == "all" ? allActivity : allActivity.filter(a -> a.type == typeFilter)
    activityCount: "{filteredActivity.length} events"
    hasNoActivity: filteredActivity.length == 0
  }

  @actions {
    setTypeFilter(v) { typeFilter = v }
  }

  layout: vertical, gap: spacing.5

  text("Activity Feed") { style: type.heading-lg }

  // Filter buttons
  block {
    padding: spacing.3
    background: "#f8fafc"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    text(activityCount) { style: type.body-sm, color: "#475569" }
    Button(label: "All", variant: "secondary") {
      on click: setTypeFilter("all")
    }
    Button(label: "Tasks", variant: "secondary") {
      on click: setTypeFilter("task_created")
    }
    Button(label: "Comments", variant: "secondary") {
      on click: setTypeFilter("comment")
    }
    Button(label: "Deploys", variant: "secondary") {
      on click: setTypeFilter("deploy")
    }
  }

  // Loading
  block {
    visibility: activityItemsLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "loader", size: "18px", color: "#6366f1")
    text("Loading activity...") { style: type.body-sm, color: "#475569" }
  }

  // Error
  block {
    visibility: activityItemsError
    padding: spacing.3
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: radius.md
    text("Failed to load activity feed.") { style: type.body-sm, color: "red" }
  }

  // Empty state
  block {
    visibility: hasNoActivity
    padding: spacing.4
    background: "#f8fafc"
    border-radius: radius.md
    layout: vertical, gap: spacing.2, align: center
    Icon(name: "clock", size: "24px", color: "#64748b")
    text("No activity events found.") { style: type.body-sm, color: "#475569" }
  }

  // Activity list
  each filteredActivity as item, idx {
    block {
      padding: spacing.3
      background: "#ffffff"
      border: "1px solid #e2e8f0"
      border-radius: radius.md
      layout: horizontal, gap: spacing.3, align: center

      ActivityIcon(item.type)

      block {
        layout: vertical, gap: spacing.1
        block {
          layout: horizontal, gap: spacing.2, align: center
          text(item.user) { style: type.label-md, weight: 600 }
          text(item.type) { style: type.label-sm, color: "#475569" }
        }
        text(item.detail) { style: type.body-sm }
        text(item.timestamp) { style: type.mono-sm, color: "#475569" }
      }
    }
  }

}

// ---------------------------------------------------------------------------
// Surface: NotificationsPanel — notification list with severity levels
// ---------------------------------------------------------------------------

surface NotificationsPanel {
  @source {
    notifications: NotificationsAPI
  }

  @state {
    severityFilter: "all"
    readFilter: "all"
  }

  @computed {
    allNotifications: notifications != null ? notifications : []
    filteredNotifications: severityFilter == "all" ? allNotifications : allNotifications.filter(n -> n.severity == severityFilter)
    notifCount: "{filteredNotifications.length} notifications"
    hasNoNotifications: filteredNotifications.length == 0
  }

  @actions {
    setSeverityFilter(v) { severityFilter = v }
  }

  layout: vertical, gap: spacing.5

  text("Notifications") { style: type.heading-lg }

  // Summary bar
  block {
    padding: spacing.3
    background: "#eef2ff"
    border-radius: radius.md
    layout: horizontal, gap: spacing.4, align: center
    Icon(name: "bell", size: "20px", color: "#6366f1")
    text(notifCount) { style: type.body-md }
  }

  // Filters
  block {
    padding: spacing.3
    background: "#f8fafc"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    text("Severity:") { style: type.label-sm, color: "#475569" }
    Button(label: "All", variant: "secondary") {
      on click: setSeverityFilter("all")
    }
    Button(label: "Info", variant: "secondary") {
      on click: setSeverityFilter("info")
    }
    Button(label: "Success", variant: "secondary") {
      on click: setSeverityFilter("success")
    }
    Button(label: "Warning", variant: "secondary") {
      on click: setSeverityFilter("warning")
    }
    Button(label: "Error", variant: "secondary") {
      on click: setSeverityFilter("error")
    }
  }

  // Loading
  block {
    visibility: notificationsLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    text("Loading notifications...") { style: type.body-sm, color: "#475569" }
  }

  // Error
  block {
    visibility: notificationsError
    padding: spacing.3
    background: "#fef2f2"
    border: "1px solid #fecaca"
    border-radius: radius.md
    text("Failed to load notifications.") { style: type.body-sm, color: "red" }
  }

  // Notification rows
  each filteredNotifications as notif, idx {
    block {
      padding: spacing.3
      background: "#ffffff"
      border: "1px solid #e2e8f0"
      border-radius: radius.md
      layout: horizontal, gap: spacing.3, align: center

      Icon(name: "bell", size: "20px", color: "#6366f1")

      block {
        layout: vertical, gap: spacing.1
        text(notif.title) { style: type.body-md }
        block {
          layout: horizontal, gap: spacing.2, align: center
          SeverityBadge(notif.severity)
          text(notif.createdAt) { style: type.mono-sm, color: "#475569" }
        }
      }
    }
  }

  // Empty state
  block {
    visibility: hasNoNotifications
    padding: spacing.4
    background: "#f8fafc"
    border-radius: radius.md
    layout: vertical, gap: spacing.2, align: center
    Icon(name: "bell-off", size: "24px", color: "#64748b")
    text("No notifications match your filters.") { style: type.body-sm, color: "#475569" }
  }
}

// ---------------------------------------------------------------------------
// Surface: SettingsPanel — lots of form controls for settings
// ---------------------------------------------------------------------------

surface SettingsPanel {
  @state {
    displayName: "Admin User"
    email: "admin@example.com"
    language: "en"
    timezone: "utc"
    emailNotifications: true
    pushNotifications: false
    weeklyDigest: true
    autoSave: true
    compactMode: false
    showAvatars: true
    itemsPerPage: "25"
    dateFormat: "iso"
    saved: false
    bio: ""
  }

  @computed {
    nameError: displayName == "" ? "Display name is required" : ""
    emailError: email == "" ? "Email is required" : ""
    hasNameError: nameError != ""
    hasEmailError: emailError != ""
    isValid: nameError == "" && emailError == ""
    savedVisible: saved
    settingsSummary: "Logged in as {displayName} ({email})"
  }

  @actions {
    setDisplayName(v) { displayName = v }
    setEmail(v) { email = v }
    setLanguage(v) { language = v }
    setTimezone(v) { timezone = v }
    setEmailNotifications(v) { emailNotifications = v }
    setPushNotifications(v) { pushNotifications = v }
    setWeeklyDigest(v) { weeklyDigest = v }
    setAutoSave(v) { autoSave = v }
    setCompactMode(v) { compactMode = v }
    setShowAvatars(v) { showAvatars = v }
    setItemsPerPage(v) { itemsPerPage = v }
    setDateFormat(v) { dateFormat = v }
    setBio(v) { bio = v }
    saveSettings() {
      if isValid {
        saved = true
      }
    }
    dismissSaved() { saved = false }
  }

  layout: vertical, gap: spacing.5

  text("Settings") { style: type.heading-lg }
  text(settingsSummary) { style: type.body-sm, color: "#475569" }

  // Success banner
  block {
    visibility: savedVisible
    padding: spacing.3
    background: "#ecfdf5"
    border: "1px solid #bbf7d0"
    border-radius: radius.md
    layout: horizontal, gap: spacing.3, align: center
    Icon(name: "check", size: "20px", color: "#10b981")
    text("Settings saved successfully!") { style: type.body-md, color: "#10b981" }
    Button(label: "Dismiss", variant: "ghost") {
      on click: dismissSaved()
    }
  }

  // Profile section
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Profile") { style: type.heading-md }

    block {
      layout: horizontal, gap: spacing.4

      block {
        layout: vertical, gap: spacing.1
        Input(type: "text", label: "Display Name", value: displayName, placeholder: "Your name") {
          on change(v): { displayName = v }
        }
        block {
          visibility: hasNameError
          text(nameError) { style: type.body-sm, color: "red" }
        }
      }

      block {
        layout: vertical, gap: spacing.1
        Input(type: "text", label: "Email", value: email, placeholder: "Your email") {
          on change(v): { email = v }
        }
        block {
          visibility: hasEmailError
          text(emailError) { style: type.body-sm, color: "red" }
        }
      }
    }

    Input(type: "textarea", label: "Bio", value: bio, placeholder: "Tell us about yourself...") {
      on change(v): { bio = v }
    }
  }

  // Localization section
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Localization") { style: type.heading-md }

    block {
      layout: horizontal, gap: spacing.4

      Select(
        options: [
          {value: "en", label: "English"},
          {value: "es", label: "Spanish"},
          {value: "fr", label: "French"},
          {value: "de", label: "German"},
          {value: "ja", label: "Japanese"}
        ],
        value: language,
        label: "Language"
      ) {
        on change(v): { language = v }
      }

      Select(
        options: [
          {value: "utc", label: "UTC"},
          {value: "est", label: "US Eastern"},
          {value: "pst", label: "US Pacific"},
          {value: "cet", label: "Central European"},
          {value: "jst", label: "Japan Standard"}
        ],
        value: timezone,
        label: "Timezone"
      ) {
        on change(v): { timezone = v }
      }

      Select(
        options: [
          {value: "iso", label: "YYYY-MM-DD"},
          {value: "us", label: "MM/DD/YYYY"},
          {value: "eu", label: "DD/MM/YYYY"}
        ],
        value: dateFormat,
        label: "Date Format"
      ) {
        on change(v): { dateFormat = v }
      }
    }
  }

  // Notification preferences
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Notifications") { style: type.heading-md }

    Toggle(checked: emailNotifications, label: "Email notifications") {
      on change(v): { emailNotifications = v }
    }
    Toggle(checked: pushNotifications, label: "Push notifications") {
      on change(v): { pushNotifications = v }
    }
    Toggle(checked: weeklyDigest, label: "Weekly digest email") {
      on change(v): { weeklyDigest = v }
    }
  }

  // Display preferences
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Display") { style: type.heading-md }

    Toggle(checked: autoSave, label: "Auto-save changes") {
      on change(v): { autoSave = v }
    }
    Toggle(checked: compactMode, label: "Compact mode") {
      on change(v): { compactMode = v }
    }
    Toggle(checked: showAvatars, label: "Show avatars") {
      on change(v): { showAvatars = v }
    }

    Select(
      options: [
        {value: "10", label: "10 per page"},
        {value: "25", label: "25 per page"},
        {value: "50", label: "50 per page"},
        {value: "100", label: "100 per page"}
      ],
      value: itemsPerPage,
      label: "Items per page"
    ) {
      on change(v): { itemsPerPage = v }
    }
  }

  // Save button
  block {
    layout: horizontal, gap: spacing.3
    Button(label: "Save Settings", variant: "primary") {
      on click: saveSettings()
    }
    Button(label: "Reset", variant: "ghost")
  }
}

// ---------------------------------------------------------------------------
// Surface: AnalyticsView — charts, metrics, and progress indicators
// ---------------------------------------------------------------------------

surface AnalyticsView {
  @source {
    stats: StatsAPI
    tasks: TasksAPI
  }

  @computed {
    total: stats != null ? stats.total : 0
    done: stats != null ? stats.done : 0
    inProgress: stats != null ? stats.inProgress : 0
    todo: stats != null ? stats.todo : 0
    doneLabel: "{done} completed"
    inProgressLabel: "{inProgress} in progress"
    todoLabel: "{todo} todo"

    taskList: tasks != null ? tasks : []
    highCount: taskList.filter(t -> t.priority == "high").length
    mediumCount: taskList.filter(t -> t.priority == "medium").length
    lowCount: taskList.filter(t -> t.priority == "low").length
    highLabel: "{highCount} high priority"
    mediumLabel: "{mediumCount} medium priority"
    lowLabel: "{lowCount} low priority"

    aliceCount: taskList.filter(t -> t.assignee == "Alice").length
    bobCount: taskList.filter(t -> t.assignee == "Bob").length
    carolCount: taskList.filter(t -> t.assignee == "Carol").length
    aliceLabel: "Alice: {aliceCount} tasks"
    bobLabel: "Bob: {bobCount} tasks"
    carolLabel: "Carol: {carolCount} tasks"
  }

  layout: vertical, gap: spacing.6

  text("Analytics") { style: type.heading-lg }

  // Loading
  block {
    visibility: statsLoading
    padding: spacing.4
    background: "#f0f9ff"
    border-radius: radius.md
    layout: horizontal, gap: spacing.2, align: center
    Icon(name: "loader", size: "18px", color: "#6366f1")
    text("Loading analytics...") { style: type.body-sm, color: "#475569" }
  }

  // Key metric cards
  block {
    layout: horizontal, gap: spacing.4

    block {
      padding: spacing.4
      background: "#eef2ff"
      border-radius: radius.lg
      layout: vertical, gap: spacing.2, align: center
      Icon(name: "list", size: "28px", color: "#6366f1")
      text("{total}") { style: type.heading-lg, color: "#6366f1" }
      text("Total Tasks") { style: type.label-sm, color: "#475569" }
    }

    block {
      padding: spacing.4
      background: "#ecfdf5"
      border-radius: radius.lg
      layout: vertical, gap: spacing.2, align: center
      Icon(name: "check", size: "28px", color: "#10b981")
      text("{done}") { style: type.heading-lg, color: "#10b981" }
      text("Completed") { style: type.label-sm, color: "#475569" }
    }

    block {
      padding: spacing.4
      background: "#fffbeb"
      border-radius: radius.lg
      layout: vertical, gap: spacing.2, align: center
      Icon(name: "loader", size: "28px", color: "#f59e0b")
      text("{inProgress}") { style: type.heading-lg, color: "#f59e0b" }
      text("In Progress") { style: type.label-sm, color: "#475569" }
    }

    block {
      padding: spacing.4
      background: "#f8fafc"
      border-radius: radius.lg
      layout: vertical, gap: spacing.2, align: center
      Icon(name: "circle", size: "28px", color: "#64748b")
      text("{todo}") { style: type.heading-lg, color: "#475569" }
      text("Todo") { style: type.label-sm, color: "#475569" }
    }
  }

  // Status breakdown
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Status Breakdown") { style: type.heading-md }

    block {
      padding: spacing.3
      background: "#ecfdf5"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "check", size: "18px", color: "#10b981")
      text(doneLabel) { style: type.body-md, color: "#10b981" }
    }

    block {
      padding: spacing.3
      background: "#fffbeb"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "loader", size: "18px", color: "#f59e0b")
      text(inProgressLabel) { style: type.body-md, color: "#f59e0b" }
    }

    block {
      padding: spacing.3
      background: "#f8fafc"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "circle", size: "18px", color: "#64748b")
      text(todoLabel) { style: type.body-md, color: "#475569" }
    }
  }

  // Priority breakdown
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Priority Breakdown") { style: type.heading-md }

    block {
      padding: spacing.3
      background: "#fef2f2"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "info", size: "18px", color: "#ef4444")
      text(highLabel) { style: type.body-md, color: "#ef4444" }
    }

    block {
      padding: spacing.3
      background: "#fffbeb"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "info", size: "18px", color: "#f59e0b")
      text(mediumLabel) { style: type.body-md, color: "#f59e0b" }
    }

    block {
      padding: spacing.3
      background: "#ecfdf5"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "info", size: "18px", color: "#10b981")
      text(lowLabel) { style: type.body-md, color: "#10b981" }
    }
  }

  // Workload distribution
  block {
    padding: spacing.4
    background: "#ffffff"
    border: "1px solid #e2e8f0"
    border-radius: radius.lg
    layout: vertical, gap: spacing.4

    text("Workload Distribution") { style: type.heading-md }

    block {
      padding: spacing.3
      background: "#eef2ff"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "user", size: "18px", color: "#6366f1")
      text(aliceLabel) { style: type.body-md }
    }

    block {
      padding: spacing.3
      background: "#ecfdf5"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "user", size: "18px", color: "#10b981")
      text(bobLabel) { style: type.body-md }
    }

    block {
      padding: spacing.3
      background: "#fffbeb"
      border-radius: radius.md
      layout: horizontal, gap: spacing.2, align: center
      Icon(name: "user", size: "18px", color: "#f59e0b")
      text(carolLabel) { style: type.body-md }
    }
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
    themePreset: "enterprise"
    view: "dashboard"
    selectedTask: null
  }

  @source {
    stats: StatsAPI
  }

  @computed {
    // Theme-derived colors
    headerBg: match themePreset { "enterprise" -> "#0f172a", "social" -> "#7c3aed", "minimal" -> "#ffffff", "playful" -> "#ea580c", _ -> "#0f172a" }
    headerText: match themePreset { "enterprise" -> "#ffffff", "social" -> "#ffffff", "minimal" -> "#0f172a", "playful" -> "#ffffff", _ -> "#ffffff" }
    accentColor: match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    headerBorder: match themePreset { "enterprise" -> "1px solid #94a3b8", "social" -> "1px solid #c4b5fd", "minimal" -> "1px solid #e5e7eb", "playful" -> "2px solid #fdba74", _ -> "1px solid #e2e8f0" }
    padOuter: match themePreset { "enterprise" -> "8px 12px", "social" -> "16px", "minimal" -> "24px 32px", "playful" -> "20px", _ -> "16px" }
    cardRadius: match themePreset { "enterprise" -> "2px", "social" -> "20px", "minimal" -> "0px", "playful" -> "16px", _ -> "8px" }
    cardGap: match themePreset { "enterprise" -> "6px", "social" -> "12px", "minimal" -> "20px", "playful" -> "14px", _ -> "12px" }

    showDashboard: view == "dashboard"
    showDetail: view == "detail"
    showCreate: view == "create"
    showWizard: view == "wizard"
    showTeam: view == "team"
    showActivity: view == "activity"
    showNotifications: view == "notifications"
    showSettings: view == "settings"
    showAnalytics: view == "analytics"
    viewTitle: match view {
      "dashboard" -> "Dashboard",
      "detail" -> "Task Detail",
      "create" -> "Create Task",
      "wizard" -> "Task Wizard",
      "team" -> "Team",
      "activity" -> "Activity",
      "notifications" -> "Notifications",
      "settings" -> "Settings",
      "analytics" -> "Analytics",
      _ -> "Admin"
    }
    statsTotal: stats != null ? stats.total : 0
    statsDone: stats != null ? stats.done : 0
    statsInProgress: stats != null ? stats.inProgress : 0
    statsTodo: stats != null ? stats.todo : 0
  }

  @actions {
    setThemePreset(p) { themePreset = p }
    setView(v) { view = v }
  }

  layout: vertical, gap: cardGap

  // Header
  block {
    padding: padOuter
    background: headerBg
    border: headerBorder
    border-radius: cardRadius
    layout: horizontal, gap: spacing.4, align: center, justify: between

    block {
      layout: horizontal, gap: spacing.3, align: center
      Icon(name: "home", size: "22px", color: accentColor)
      text(viewTitle) { style: type.heading-lg, color: headerText }
    }

    block {
      layout: horizontal, gap: spacing.2, align: center
      Button(label: "Enterprise", variant: "secondary") {
        on click: setThemePreset("enterprise")
      }
      Button(label: "Social", variant: "secondary") {
        on click: setThemePreset("social")
      }
      Button(label: "Minimal", variant: "secondary") {
        on click: setThemePreset("minimal")
      }
      Button(label: "Playful", variant: "secondary") {
        on click: setThemePreset("playful")
      }
    }
  }

  // Navigation tabs
  Tabs(
    tabs: [
      {id: "dashboard", label: "Dashboard"},
      {id: "analytics", label: "Analytics"},
      {id: "team", label: "Team"},
      {id: "activity", label: "Activity"},
      {id: "notifications", label: "Notifications"},
      {id: "detail", label: "Detail"},
      {id: "create", label: "New Task"},
      {id: "wizard", label: "Wizard"},
      {id: "settings", label: "Settings"}
    ],
    activeTab: view
  ) {
    on change(v): { view = v }
  }

  // Dashboard view
  block {
    visibility: showDashboard
    layout: vertical, gap: cardGap
    StatsBar(statsTotal, statsDone, statsInProgress, statsTodo, themePreset)
    TaskTable(themePreset, selectedTask, view)
  }

  // Detail view
  block {
    visibility: showDetail
    TaskDetail(themePreset, selectedTask, view)
  }

  // Create view
  block {
    visibility: showCreate
    TaskForm(themePreset)
  }

  // Wizard view
  block {
    visibility: showWizard
    TaskWizard()
  }

  // Team view
  block {
    visibility: showTeam
    TeamDirectory()
  }

  // Activity view
  block {
    visibility: showActivity
    ActivityFeed()
  }

  // Notifications view
  block {
    visibility: showNotifications
    NotificationsPanel()
  }

  // Settings view
  block {
    visibility: showSettings
    SettingsPanel()
  }

  // Analytics view
  block {
    visibility: showAnalytics
    AnalyticsView()
  }
}
