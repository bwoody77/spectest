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
@import { ThemePreview } from "./surfaces/theme-preview.spec"
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
    themePreset: "default"
    view: "dashboard" @route
    selectedTask: null
    sidebarCollapsed: false
    commandPaletteOpen: false
    currentLocale: getCurrentLocale()
  }

  @source {
    stats: StatsAPI
  }

  @computed {
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
    showThemePreview: view == "themepreview"

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
      "themepreview" -> "Theme Preview",
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
      "themepreview" -> "Design",
      _ -> "Overview"
    }

    statsTotal: stats != null ? stats.total : 0
    statsDone: stats != null ? stats.done : 0
    statsInProgress: stats != null ? stats.inProgress : 0
    statsTodo: stats != null ? stats.todo : 0

    appColorScheme: themePreset == "dark" || themePreset == "geek" || themePreset == "glass" ? "dark" : "light"
    fullHeight: "100vh"
    headerPad: "10px 20px"
    breadcrumbPad: "8px 20px"
    fullWidth: "100%"
  }

  @actions {
    setThemePreset(p) { themePreset = p }
    setView(v) { view = v }
    toggleSidebar() { sidebarCollapsed = !sidebarCollapsed }
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
    height: fullHeight
    overflow: hidden
    background: semantic.surface
    layout: vertical

  // Header bar (Issue #50, #54, #57)
  block {
    role: "banner"
    padding: headerPad
    background: semantic.background
    border-bottom: borders.default
    shadow: elevation.raised
    layout: horizontal, gap: spacing.4, align: center, justify: between

    // Left: title
    block {
      layout: horizontal, gap: spacing.3, align: center

      Icon(name: "home", size: icon.lg, color: semantic.interactive)
      text("Spec Admin") {
        style: type.heading-lg
        color: semantic.text-primary
        letter-spacing: "-0.02em"
      }
    }

    // Right: theme switcher + dark mode + command palette hint
    block {
      layout: horizontal, gap: spacing.3, align: center

      // Theme selector
      Select(
        options: [
          {value: "default", label: "Default"},
          {value: "dark", label: "Dark"},
          {value: "mui", label: "MUI"},
          {value: "shadcn", label: "shadcn"},
          {value: "cartoon", label: "Cartoon"},
          {value: "illustration", label: "Illustration"},
          {value: "bootstrap", label: "Bootstrap"},
          {value: "glass", label: "Glass"},
          {value: "geek", label: "Geek"}
        ],
        value: themePreset,
        label: "Theme"
      ) {
        on change(v): setThemePreset(v)
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

      // Command palette trigger (Issue #18)
      Button(label: "⌘K", variant: "ghost") {
        on click: openCommandPalette()
      }
    }
  }

  // Breadcrumb navigation (Issue #18)
  block {
    padding: breadcrumbPad
    background: semantic.surface-raised
    border-bottom: borders.default
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
    grow: true
    layout: horizontal
    overflow: hidden

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
        {heading: "Design", items: [
          {id: "themepreview", label: "Theme Preview", icon: "palette"}
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
      grow: true
      padding: spacing.5
      background: semantic.surface
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
        TaskTable(selectedTask, view)
      }

      // Detail view
      block {
        role: "region"
        aria-label: "Task detail"
        visibility: showDetail
        TaskDetail(selectedTask, view)
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

      // Theme Preview
      block {
        role: "region"
        aria-label: "Theme preview"
        visibility: showThemePreview
        ThemePreview()
      }

      // Performance: Grid 10K
      block {
        role: "region"
        aria-label: "Grid performance"
        visibility: showPerfGrid
        PerfGrid()
      }

      // Performance: Signal throughput
      block {
        role: "region"
        aria-label: "Signal performance"
        visibility: showPerfSignals
        PerfSignals()
      }
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
      {id: "themepreview", label: "Theme Preview", group: "Design", icon: "palette"},
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
