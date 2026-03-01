// ---------------------------------------------------------------------------
// Gate #22 — Enhanced Admin Dashboard
// Exercises all features from Issues 17-21 (Tier 4-6 components + production codegen)
// and Issues 49-59 (visual system enhancements).
//
// New in Gate #22:
//   Components: Sidebar, Breadcrumb, CommandPalette, DataGrid, EditableGrid,
//     Tree, Timeline, Card, Stat, Badge, EmptyState, Stepper, Pagination,
//     Toast, Alert, Progress, Skeleton, ConfirmDialog, Drawer, Accordion
//   Visual: hover/focus/active states, CSS Grid, responsive breakpoints,
//     gradients, shadows, transforms, transitions, backdrop-blur,
//     text styling (letter-spacing, text-transform, text-decoration),
//     individual borders, positioned layout, dark mode, opacity, cursor
//
// Performance (measured 2026-02-28):
//   Bundle: 121 KB raw, ~18 KB gzipped (2,542 lines)
//   Surfaces/components compiled: 25 mount functions
//   Components used: 25 built-in (Accordion, Alert, Badge, Breadcrumb, Button,
//     Card, Checkbox, CommandPalette, ConfirmDialog, DataGrid, DatePicker,
//     Drawer, EditableGrid, EmptyState, Icon, Image, Input, Pagination,
//     Popover, Progress, Select, Sidebar, Skeleton, Stepper, Stat, Timeline,
//     Toggle, Tooltip, Tree) + 6 declared components
//   Runtime features: createBreakpoints, syncHash, lazyMount, bindCollection,
//     bindStyle, bindText, bindVisibility, computed, createSignal, createSource
// ---------------------------------------------------------------------------

// Design tokens + theme presets
@import "../visual-system.spec"

// Multi-file imports
@import { StatusBadge, PriorityBadge, SeverityBadge, ActivityIcon, UserAvatar, ProductStatusBadge } from "./components/badges.spec"
@import { StatsBar } from "./surfaces/stats-bar.spec"
@import { TaskTable } from "./surfaces/task-table.spec"
@import { TaskForm } from "./surfaces/task-form.spec"
@import { TaskDetail } from "./surfaces/task-detail.spec"
@import { WizardStep1, WizardStep2, WizardStep3, WizardDone, WizardStepper, TaskWizard } from "./surfaces/wizard.spec"
@import { TeamDirectory } from "./surfaces/team.spec"
@import { ActivityFeed } from "./surfaces/activity.spec"
@import { NotificationsPanel } from "./surfaces/notifications.spec"
@import { SettingsPanel } from "./surfaces/settings.spec"
@import { AnalyticsView } from "./surfaces/analytics.spec"
@import { DataGridDemo } from "./surfaces/data-grid-demo.spec"
@import { EditableGridDemo } from "./surfaces/editable-grid-demo.spec"
@import { TreeDemo } from "./surfaces/tree-demo.spec"
// @import { PerfGrid } from "./surfaces/perf-grid.spec"
// @import { PerfSignals } from "./surfaces/perf-signals.spec"

// Internationalization
@i18n {
  defaultLocale: "en"
  locales: ["en", "es"]
  fallback: "en"
  translationDir: "./i18n"
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

source ProductsAPI {
  endpoint: "http://localhost:4000/api/products"
  method: GET
  cache: 5
}

source CategoriesAPI {
  endpoint: "http://localhost:4000/api/categories"
  method: GET
  cache: 10
}

// ---------------------------------------------------------------------------
// Surface: App — main shell with Sidebar navigation
// ---------------------------------------------------------------------------

surface App {
  @state {
    themePreset: "enterprise"
    view: "dashboard" @route
    selectedTask: null
    sidebarCollapsed: false
    commandPaletteOpen: false
    darkMode: false
    currentLocale: getCurrentLocale()
  }

  @source {
    stats: StatsAPI
  }

  @computed {
    // Theme-derived colors (Issue #53 reactive)
    headerBg: darkMode ? "#0f172a" : match themePreset { "enterprise" -> "#0f172a", "social" -> "#7c3aed", "minimal" -> "#ffffff", "playful" -> "#ea580c", _ -> "#0f172a" }
    headerText: darkMode ? "#f1f5f9" : match themePreset { "enterprise" -> "#ffffff", "social" -> "#ffffff", "minimal" -> "#0f172a", "playful" -> "#ffffff", _ -> "#ffffff" }
    accentColor: darkMode ? "#818cf8" : match themePreset { "enterprise" -> "#3b82f6", "social" -> "#8b5cf6", "minimal" -> "#0f172a", "playful" -> "#f97316", _ -> "#3b82f6" }
    mainBg: darkMode ? "#020617" : match themePreset { "enterprise" -> "#f1f5f9", "social" -> "#f5f3ff", "minimal" -> "#ffffff", "playful" -> "#fff7ed", _ -> "#f1f5f9" }
    contentBg: darkMode ? "#0f172a" : match themePreset { "enterprise" -> "#ffffff", "social" -> "#ffffff", "minimal" -> "#ffffff", "playful" -> "#ffffff", _ -> "#ffffff" }
    borderColor: darkMode ? "#334155" : match themePreset { "enterprise" -> "#e2e8f0", "social" -> "#ddd6fe", "minimal" -> "#e5e7eb", "playful" -> "#fed7aa", _ -> "#e2e8f0" }
    textPrimary: darkMode ? "#f1f5f9" : match themePreset { "enterprise" -> "#1e293b", "social" -> "#581c87", "minimal" -> "#0f172a", "playful" -> "#7c2d12", _ -> "#1e293b" }
    textMuted: darkMode ? "#94a3b8" : match themePreset { "enterprise" -> "#475569", "social" -> "#7c3aed", "minimal" -> "#6b7280", "playful" -> "#ea580c", _ -> "#475569" }

    // View visibility flags
    showDashboard: view == "dashboard"
    showDetail: view == "detail"
    showCreate: view == "create"
    showWizard: view == "wizard"
    showTeam: view == "team"
    showActivity: view == "activity"
    showNotifications: view == "notifications"
    showSettings: view == "settings"
    showAnalytics: view == "analytics"
    showDataGrid: view == "datagrid"
    showEditGrid: view == "editgrid"
    showTree: view == "categories"
    showPerfGrid: view == "perfgrid"
    showPerfSignals: view == "perfsignals"

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
      "datagrid" -> "Product Catalog",
      "editgrid" -> "Editable Inventory",
      "categories" -> "Categories",
      "perfgrid" -> "Grid Performance",
      "perfsignals" -> "Signal Performance",
      _ -> "Admin"
    }

    // Breadcrumb segments
    breadcrumbSection: match view {
      "dashboard" -> "Overview",
      "detail" -> "Tasks",
      "create" -> "Tasks",
      "wizard" -> "Tasks",
      "team" -> "People",
      "activity" -> "Monitoring",
      "notifications" -> "Monitoring",
      "settings" -> "System",
      "analytics" -> "Monitoring",
      "datagrid" -> "Data",
      "editgrid" -> "Data",
      "categories" -> "Data",
      "perfgrid" -> "Performance",
      "perfsignals" -> "Performance",
      _ -> "Overview"
    }

    statsTotal: stats != null ? stats.total : 0
    statsDone: stats != null ? stats.done : 0
    statsInProgress: stats != null ? stats.inProgress : 0
    statsTodo: stats != null ? stats.todo : 0

    darkModeIcon: darkMode ? "sun" : "moon"
    darkModeLabel: darkMode ? "Light Mode" : "Dark Mode"
    appColorScheme: darkMode ? "dark" : "light"
    fullHeight: "100vh"
    headerPad: "10px 20px"
    breadcrumbPad: "8px 20px"
    contentMinHeight: "calc(100vh - 100px)"
    fullWidth: "100%"
  }

  @actions {
    setThemePreset(p) { themePreset = p }
    setView(v) { view = v }
    toggleSidebar() { sidebarCollapsed = !sidebarCollapsed }
    toggleDarkMode() { darkMode = !darkMode }
    openCommandPalette() { commandPaletteOpen = true }
    closeCommandPalette() { commandPaletteOpen = false }
    navigateTo(v) {
      view = v
      commandPaletteOpen = false
    }
    setLocale(lang) {
      currentLocale = lang
      switchLocale(lang)
    }
  }

  layout: vertical

  // Root wrapper with dark mode (Issue #59) and full-height layout
  block {
    colorScheme: appColorScheme
    min-height: fullHeight
    background: mainBg
    layout: vertical

  // Header bar (Issue #50, #54, #57)
  block {
    role: "banner"
    padding: headerPad
    background: headerBg
    border-bottom: "1px solid {borderColor}"
    shadow: elevation.raised
    layout: horizontal, gap: spacing.4, align: center, justify: between

    // Left: menu toggle + title
    block {
      layout: horizontal, gap: spacing.3, align: center

      Button(label: "☰", variant: "ghost") {
        on click: toggleSidebar()
      }

      Icon(name: "home", size: "22px", color: accentColor)
      text("Spec Admin") {
        style: type.heading-lg
        color: headerText
        letter-spacing: "-0.02em"
      }
    }

    // Right: theme switcher + dark mode + command palette hint
    block {
      layout: horizontal, gap: spacing.3, align: center

      // Theme buttons
      block {
        role: "toolbar"
        aria-label: "Theme selection"
        layout: horizontal, gap: spacing.1, align: center
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

      // Language selector
      block {
        layout: horizontal, gap: spacing.1, align: center
        Button(label: "EN", variant: currentLocale == "en" ? "primary" : "secondary") {
          on click: setLocale("en")
        }
        Button(label: "ES", variant: currentLocale == "es" ? "primary" : "secondary") {
          on click: setLocale("es")
        }
      }

      // Dark mode toggle (Issue #59)
      Button(label: darkModeLabel, variant: "ghost") {
        on click: toggleDarkMode()
      }

      // Command palette trigger (Issue #18)
      Button(label: "⌘K", variant: "ghost") {
        on click: openCommandPalette()
      }
    }
  }

  // Breadcrumb navigation (Issue #18)
  block {
    padding: breadcrumbPad
    background: contentBg
    border-bottom: "1px solid {borderColor}"
    Breadcrumb(
      items: [
        {id: "dashboard", label: "Home"},
        {id: view, label: breadcrumbSection},
        {id: view, label: viewTitle}
      ]
    ) {
      on select(id): { view = id }
    }
  }

  // Main content area: Sidebar + content
  block {
    layout: horizontal
    min-height: contentMinHeight

    // Sidebar navigation (Issue #18)
    Sidebar(
      sections: [
        {heading: "Overview", items: [
          {id: "dashboard", label: "Dashboard", icon: "home"},
          {id: "analytics", label: "Analytics", icon: "bar-chart"}
        ]},
        {heading: "Tasks", items: [
          {id: "detail", label: "Task Detail", icon: "eye"},
          {id: "create", label: "Create Task", icon: "plus"},
          {id: "wizard", label: "Task Wizard", icon: "list"}
        ]},
        {heading: "Data", items: [
          {id: "datagrid", label: "Product Catalog", icon: "layout"},
          {id: "editgrid", label: "Editable Grid", icon: "edit"},
          {id: "categories", label: "Categories", icon: "list"}
        ]},
        {heading: "People", items: [
          {id: "team", label: "Team", icon: "user"}
        ]},
        {heading: "Monitoring", items: [
          {id: "activity", label: "Activity", icon: "clock"},
          {id: "notifications", label: "Notifications", icon: "bell"}
        ]},
        {heading: "Performance", items: [
          {id: "perfgrid", label: "Grid 10K", icon: "zap"},
          {id: "perfsignals", label: "Signal Test", icon: "activity"}
        ]},
        {heading: "System", items: [
          {id: "settings", label: "Settings", icon: "settings"}
        ]}
      ],
      activeItem: view,
      collapsed: sidebarCollapsed
    ) {
      on select(id): { view = id }
      on collapse(c): { sidebarCollapsed = c }
    }

    // Main content area
    block {
      padding: spacing.5
      background: mainBg
      layout: vertical, gap: spacing.5
      overflow: "auto"
      width: fullWidth

      // Dashboard view
      block {
        role: "region"
        aria-label: "Dashboard"
        visibility: showDashboard
        layout: vertical, gap: spacing.5
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

      // Wizard view with Stepper (Issue #18)
      block {
        role: "region"
        aria-label: "Task wizard"
        visibility: showWizard
        layout: vertical, gap: spacing.5
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

      // DataGrid view (Issue #17)
      block {
        role: "region"
        aria-label: "Product catalog"
        visibility: showDataGrid
        DataGridDemo(themePreset)
      }

      // EditableGrid view (Issue #20)
      block {
        role: "region"
        aria-label: "Editable inventory"
        visibility: showEditGrid
        EditableGridDemo(themePreset)
      }

      // Tree view (Issue #17)
      block {
        role: "region"
        aria-label: "Category browser"
        visibility: showTree
        TreeDemo(themePreset)
      }

      // Performance: Grid 10K
      // block {
      //   role: "region"
      //   aria-label: "Grid performance"
      //   visibility: showPerfGrid
      //   PerfGrid()
      // }

      // // Performance: Signal throughput
      // block {
      //   role: "region"
      //   aria-label: "Signal performance"
      //   visibility: showPerfSignals
      //   PerfSignals()
      // }
    }
  }

  // CommandPalette overlay (Issue #18, #57 backdrop-blur)
  CommandPalette(
    commands: [
      {id: "dashboard", label: "Dashboard", group: "Views", icon: "home"},
      {id: "analytics", label: "Analytics", group: "Views", icon: "bar-chart"},
      {id: "team", label: "Team Directory", group: "Views", icon: "user"},
      {id: "activity", label: "Activity Feed", group: "Views", icon: "clock"},
      {id: "notifications", label: "Notifications", group: "Views", icon: "bell"},
      {id: "detail", label: "Task Detail", group: "Tasks", icon: "eye"},
      {id: "create", label: "Create Task", group: "Tasks", icon: "plus"},
      {id: "wizard", label: "Task Wizard", group: "Tasks", icon: "list"},
      {id: "datagrid", label: "Product Catalog", group: "Data", icon: "layout"},
      {id: "editgrid", label: "Editable Grid", group: "Data", icon: "edit"},
      {id: "categories", label: "Categories", group: "Data", icon: "list"},
      {id: "perfgrid", label: "Grid Performance", group: "Performance", icon: "zap"},
      {id: "perfsignals", label: "Signal Performance", group: "Performance", icon: "activity"},
      {id: "settings", label: "Settings", group: "System", icon: "settings"}
    ],
    placeholder: "Search views, actions..."
  ) {
    on select(id): { navigateTo(id) }
    on close: closeCommandPalette()
  }

  } // close root wrapper block
}
