// ---------------------------------------------------------------------------
// Gate #16 — Admin Dashboard
// Exercises: sources, flows, forms, each, visibility, computed, actions,
//            multi-surface composition, theme switching, Input, Select,
//            DatePicker, Button, Toggle, Checkbox, Icon, Image,
//            form validation, template strings, pipes, match expressions,
//            guarded flow transitions, component declarations,
//            @import, @theme, @route, lazy mounting
// ---------------------------------------------------------------------------

@visual-system {
  spacing: 4px-unit
  type-scale: 1.25-ratio, base 14px
  palette: slate(neutral), indigo(primary), red(danger), emerald(success), amber(warning)
  radius: 6px(sm), 8px(md), 12px(lg), 9999px(full)
  motion: 150ms ease(default), 300ms ease(slow)
}

// Theme presets — override palette/semantic tokens per theme
@theme enterprise {
  palette.primary: blue
  semantic.surface: "#f1f5f9"
  semantic.border: "#94a3b8"
  semantic.text-primary: "#1e293b"
  semantic.text-secondary: "#475569"
}

@theme social {
  palette.primary: violet
  semantic.surface: "#f5f3ff"
  semantic.border: "#a78bfa"
  semantic.text-primary: "#581c87"
  semantic.text-secondary: "#7c3aed"
}

@theme minimal {
  palette.primary: slate
  semantic.surface: "#ffffff"
  semantic.border: "#d4d4d4"
  semantic.text-primary: "#0f172a"
  semantic.text-secondary: "#6b7280"
}

@theme playful {
  palette.primary: orange
  semantic.surface: "#fff7ed"
  semantic.border: "#fb923c"
  semantic.text-primary: "#7c2d12"
  semantic.text-secondary: "#ea580c"
}

// Multi-file imports
@import { StatusBadge, PriorityBadge, SeverityBadge, ActivityIcon, UserAvatar } from "./components/badges.spec"
@import { StatsBar } from "./surfaces/stats-bar.spec"
@import { TaskTable } from "./surfaces/task-table.spec"
@import { TaskForm } from "./surfaces/task-form.spec"
@import { TaskDetail } from "./surfaces/task-detail.spec"
@import { WizardStep1, WizardStep2, WizardStep3, WizardDone, TaskWizard } from "./surfaces/wizard.spec"
@import { TeamDirectory } from "./surfaces/team.spec"
@import { ActivityFeed } from "./surfaces/activity.spec"
@import { NotificationsPanel } from "./surfaces/notifications.spec"
@import { SettingsPanel } from "./surfaces/settings.spec"
@import { AnalyticsView } from "./surfaces/analytics.spec"

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
// Surface: App — main shell (auto-mounted by dev server)
// ---------------------------------------------------------------------------

surface App {
  @state {
    themePreset: "enterprise"
    view: "dashboard" @route
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
    role: "banner"
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
      role: "toolbar"
      aria-label: "Theme selection"
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
    role: "region"
    aria-label: "Dashboard"
    visibility: showDashboard
    layout: vertical, gap: cardGap
    StatsBar(statsTotal, statsDone, statsInProgress, statsTodo, themePreset)
    TaskTable(themePreset, selectedTask, view)
  }

  // Detail view
  block {
    role: "region"
    aria-label: "Task detail"
    visibility: showDetail
    TaskDetail(themePreset, selectedTask, view)
  }

  // Create view
  block {
    role: "region"
    aria-label: "Create task"
    visibility: showCreate
    TaskForm(themePreset)
  }

  // Wizard view
  block {
    role: "region"
    aria-label: "Task wizard"
    visibility: showWizard
    TaskWizard()
  }

  // Team view
  block {
    role: "region"
    aria-label: "Team directory"
    visibility: showTeam
    TeamDirectory()
  }

  // Activity view
  block {
    role: "region"
    aria-label: "Activity feed"
    visibility: showActivity
    ActivityFeed()
  }

  // Notifications view
  block {
    role: "region"
    aria-label: "Notifications"
    visibility: showNotifications
    NotificationsPanel()
  }

  // Settings view
  block {
    role: "region"
    aria-label: "Settings"
    visibility: showSettings
    SettingsPanel()
  }

  // Analytics view
  block {
    role: "region"
    aria-label: "Analytics"
    visibility: showAnalytics
    AnalyticsView()
  }
}
