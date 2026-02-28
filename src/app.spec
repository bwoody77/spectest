// ---------------------------------------------------------------------------
// Gate #16 — Admin Dashboard
// Exercises: sources, flows, forms, each, visibility, computed, actions,
//            multi-surface composition, theme switching, Input, Select,
//            DatePicker, Button, Toggle, Checkbox, Icon, Image,
//            Modal, Tooltip, Popover (overlay components),
//            form validation, template strings, pipes, match expressions,
//            guarded flow transitions, component declarations,
//            @import, @theme, @route, lazy mounting
//
// Performance (measured 2026-02-28):
//   Bundle: 124 KB raw, ~17 KB gzipped (2,859 lines)
//   Runtime: @spec/runtime ~48 KB total (all modules)
//   Surfaces/components compiled: 18 mount functions
//   Components used: 15 built-in (Input, Select, Button, DatePicker, Toggle,
//     Checkbox, Icon, Image, Tabs, Modal, Tooltip, Popover, StatusBadge,
//     PriorityBadge, SeverityBadge) + 5 declared components
//
// Known limitations: see KNOWN_LIMITATIONS.md
// ---------------------------------------------------------------------------

// Design tokens + theme presets (bare import — brings in @visual-system and @theme blocks)
@import "../visual-system.spec"

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
