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
//   Components used: 24 built-in (Accordion, Badge, Breadcrumb, Button,
//     Card, Checkbox, CommandPalette, ConfirmDialog, DataGrid, DatePicker,
//     Drawer, EditableGrid, EmptyState, Icon, Image, Input, Pagination,
//     Popover, Progress, Select, Sidebar, Skeleton, Stepper, Stat, Timeline,
//     Toggle, Tooltip, Tree) + 7 declared components (incl. Alert.spec)
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
@import { ThemeBuilder } from "./surfaces/theme-builder.spec"
// @import { Landing2 } from "./surfaces/landing2.spec"
// @import { PerfGrid } from "./surfaces/perf-grid.spec"
// @import { PerfSignals } from "./surfaces/perf-signals.spec"

// Internationalization
@i18n {
  defaultLocale: "en"
  locales: ["en", "es"]
  fallback: "en"
  translationDir: "./i18n"
}

@extern { strangerThingsTransition } from "./theme-effects.js"
@extern { startBuilderPreview, cancelBuilderPreview, saveBuilderAsTheme } from "./theme-builder.js"

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
    themePreset: "default" @persist
    view: "dashboard" @route
    selectedTask: null
    sidebarCollapsed: false
    mobileNavOpen: false
    commandPaletteOpen: false
    themeDrawerOpen: false
    themeBuilderOpen: false
    builderSaveName: ''
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
    showLanding2: view == "landing2"
    isLandingPage: view == "landing2"

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
      "landing2" -> "Landing Page",
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
      "landing2" -> "Marketing",
      _ -> "Overview"
    }

    statsTotal: stats != null ? stats.total : 0
    statsDone: stats != null ? stats.done : 0
    statsInProgress: stats != null ? stats.inProgress : 0
    statsTodo: stats != null ? stats.todo : 0

    appColorScheme: themePreset == "dark" || themePreset == "geek" || themePreset == "glass" || themePreset == "nord" || themePreset == "cyberpunk" || themePreset == "dracula" || themePreset == "ocean" || themePreset == "monokai" || themePreset == "retro" || themePreset == "gruvbox" || themePreset == "catppuccin" || themePreset == "synthwave" || themePreset == "rose-pine" || themePreset == "cobalt" || themePreset == "stranger-things" || themePreset == "mtg" ? "dark" : "light"
    fullHeight: "100vh"
    fullWidth: "100%"
  }

  @actions {
    openThemeBuilder() {
      themeBuilderOpen = true
      themeDrawerOpen = false
      startBuilderPreview(themePreset)
    }
    cancelThemeBuilder() {
      themeBuilderOpen = false
      cancelBuilderPreview()
    }
    saveBuilderTheme() {
      saveBuilderAsTheme(builderSaveName)
      themePreset = builderSaveName
      themeBuilderOpen = false
      builderSaveName = ''
    }
    setBuilderSaveName(v) { builderSaveName = v }
    applyStrangerThemes() {
      themePreset = "stranger-things"
      themeDrawerOpen = false
    }
    setThemePreset(p) {
      if (p == "stranger-things") {
        themeDrawerOpen = false
        strangerThingsTransition(applyStrangerThemes)
      }
      if (p != "stranger-things") {
        themePreset = p
      }
    }
    setView(v) { view = v }
    toggleThemeDrawer() {
      themeDrawerOpen = !themeDrawerOpen
      themeBuilderOpen = false
    }
    closeThemeDrawer() { themeDrawerOpen = false }
    toggleSidebar() {
      sidebarCollapsed = !sidebarCollapsed
      mobileNavOpen = !mobileNavOpen
    }
    closeMobileNav() { mobileNavOpen = false }
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

  // Landing page — full viewport, no admin shell
  // Landing page placeholder (landing2.spec.wip not yet compiled)
  // block {
  //   visibility: isLandingPage
  //   colorScheme: appColorScheme
  //   height: fullHeight
  //   overflow: auto
  //   background: "#0f172a"
  //   Landing2(view)
  // }

  // Root wrapper with dark mode (Issue #59) and full-height layout
  block {
    visibility: !isLandingPage
    colorScheme: appColorScheme
    height: fullHeight
    overflow: hidden
    background: gradient.app-background
    layout: vertical

  block {
    grow: true
    overflow: hidden
    background: semantic.surface
    layout: vertical

  // Header bar (Issue #50, #54, #57)
  block {
    role: "banner"
    padding-y: responsive(6px, md: 10px)
    padding-x: responsive(12px, md: 20px)
    background: semantic.background
    border-bottom: borders.default
    shadow: elevation.raised
    layout: horizontal, gap: spacing.4, align: center, justify: between

    // Left: hamburger + title
    block {
      layout: horizontal, gap: spacing.3, align: center

      Button(label: "☰", variant: "ghost") {
        on click: toggleSidebar()
      }
      Icon(name: "home", size: icon.lg, color: semantic.interactive)
      text("Spec Admin") {
        style: type.heading-lg
        color: semantic.text-primary
        letter-spacing: "-0.02em"
      }
    }

    // Right: theme switcher + dark mode + command palette hint
    block {
      layout: horizontal, gap: spacing.2, align: center

      // Theme chooser panel trigger
      Button(label: "Theme", variant: "secondary", pressed: themeDrawerOpen) {
        on click: toggleThemeDrawer()
      }

      // Theme Builder trigger
      Button(label: "Build Theme", variant: "secondary", pressed: themeBuilderOpen) {
        on click: openThemeBuilder()
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

  // Theme chooser — right-side panel (no backdrop, page stays scrollable)
  block {
    visibility: themeDrawerOpen
    position: fixed
    top: 0px
    right: 0px
    bottom: 0px
    width: responsive(280px, md: 320px)
    z-index: 50
    background: semantic.surface-raised
    border-left: borders.default
    shadow: elevation.overlay
    overflow: hidden
    layout: vertical

    // Header (fixed at top)
    block {
      padding: spacing.3
      border-bottom: borders.default
      layout: horizontal, justify: between, align: center
      text("Themes") { style: type.heading-sm, color: semantic.text-primary }
      Button(label: "✕", variant: "ghost") {
        on click: closeThemeDrawer()
      }
    }

    // Theme grid (scrollable)
    block {
      grow: true
      overflow: auto
      padding: spacing.4

      block {
        layout: grid, columns: "1fr 1fr", gap: spacing.3

        each [{value: "gruvbox", label: "Gruvbox", bg: "#282828", fg: "#EBDBB2", accent: "#FE8019", bdr: "#504945"},
            {value: "shadcn", label: "shadcn", bg: "#fafafa", fg: "#09090b", accent: "#18181b", bdr: "#e4e4e7"},
            {value: "solarized", label: "Solarized", bg: "#EEE8D5", fg: "#073642", accent: "#2AA198", bdr: "#93A1A1"},
            {value: "stranger-things", label: "Stranger Things", bg: "#0C0808", fg: "#F0D8D0", accent: "#E82020", bdr: "#3A1C1C"},
            {value: "cartoon", label: "Cartoon", bg: "#fdf6ec", fg: "#2d3748", accent: "#2d6a4f", bdr: "#e2d5c1"},
            {value: "geek", label: "Geek", bg: "#0a0a0a", fg: "#00ff41", accent: "#00ff41", bdr: "#1a3a1a"},
            {value: "nord", label: "Nord", bg: "#2E3440", fg: "#ECEFF4", accent: "#88C0D0", bdr: "#3B4252"},
            {value: "illustration", label: "Illustration", bg: "#fff9f0", fg: "#1a1a2e", accent: "#52c41a", bdr: "#e8dfd6"},
            {value: "mtg", label: "MTG", bg: "#1C1712", fg: "#E8DCC8", accent: "#D4A836", bdr: "#5C4A30"},
            {value: "cyberpunk", label: "Cyberpunk", bg: "#0D001A", fg: "#F0ABFC", accent: "#FF2D95", bdr: "#2D0050"},
            {value: "pastel", label: "Pastel", bg: "#F8F6FF", fg: "#2D2642", accent: "#9B72CF", bdr: "#E0D8F0"},
            {value: "newspaper", label: "Newspaper", bg: "#FFFEF9", fg: "#1A1A1A", accent: "#8B0000", bdr: "#D8D0C4"},
            {value: "high-contrast", label: "Hi-Contrast", bg: "#FFFFFF", fg: "#000000", accent: "#0050D8", bdr: "#000000"},
            {value: "retro", label: "Retro", bg: "#0A0800", fg: "#FFB000", accent: "#FFB000", bdr: "#3D2200"},
            {value: "dracula", label: "Dracula", bg: "#282A36", fg: "#F8F8F2", accent: "#BD93F9", bdr: "#44475A"},
            {value: "sunset", label: "Sunset", bg: "#FFF8F1", fg: "#1C1917", accent: "#EA580C", bdr: "#FFEDD5"},
            {value: "default", label: "Default", bg: "#f7f7f8", fg: "#202732", accent: "#1677ff", bdr: "#dce0e5"},
            {value: "dark", label: "Dark", bg: "#0f172a", fg: "#e2e8f0", accent: "#818cf8", bdr: "#334155"},
            {value: "mui", label: "MUI", bg: "#ffffff", fg: "#212121", accent: "#1976d2", bdr: "#e0e0e0"},
            {value: "bootstrap", label: "Bootstrap", bg: "#ffffff", fg: "#212529", accent: "#0d6efd", bdr: "#dee2e6"},
            {value: "glass", label: "Glass", bg: "rgba(15,23,42,0.85)", fg: "#e2e8f0", accent: "#a78bfa", bdr: "rgba(255,255,255,0.15)"},
            {value: "sakura", label: "Sakura", bg: "#FFF5F5", fg: "#1A1A2E", accent: "#E11D48", bdr: "#FECDD3"},
            {value: "ocean", label: "Ocean", bg: "#0C1929", fg: "#CBD5E1", accent: "#2DD4BF", bdr: "#1E3A5F"},
            {value: "lavender", label: "Lavender", bg: "#F5F3FF", fg: "#1E1B4B", accent: "#7C3AED", bdr: "#DDD6FE"},
            {value: "brutalist", label: "Brutalist", bg: "#FFFFFF", fg: "#000000", accent: "#000000", bdr: "#000000"},
            {value: "monokai", label: "Monokai", bg: "#272822", fg: "#F8F8F2", accent: "#F92672", bdr: "#3E3D32"},
            {value: "earth", label: "Earth", bg: "#F5F0EB", fg: "#292524", accent: "#B45309", bdr: "#D6CFC7"},
            {value: "catppuccin", label: "Catppuccin", bg: "#1E1E2E", fg: "#CDD6F4", accent: "#CBA6F7", bdr: "#45475A"},
            {value: "synthwave", label: "Synthwave", bg: "#241B2F", fg: "#F0E8FF", accent: "#FF7AC6", bdr: "#463868"},
            {value: "rose-pine", label: "Rosé Pine", bg: "#191724", fg: "#E0DEF4", accent: "#EBBCBA", bdr: "#3A3650"},
            {value: "cobalt", label: "Cobalt", bg: "#15232D", fg: "#E1EFFF", accent: "#FFC600", bdr: "#1E4263"}
           ] as theme {
        block {
          padding: spacing.2
          border-radius: radius.md
          background: theme.bg
          border: themePreset == theme.value ? "2px solid " + theme.accent : "2px solid " + theme.bdr
          cursor: pointer
          on click: setThemePreset(theme.value)
          layout: vertical, gap: spacing.1

          // Accent bar
          block {
            height: 4px
            border-radius: 2px
            background: theme.accent
          }

          // Text sample
          text("Aa") {
            style: type.body-lg
            color: theme.fg
          }

          // Theme name
          text(theme.label) {
            style: type.body-sm
            color: theme.fg
          }

          // Color dots
          block {
            layout: horizontal, gap: 4px, align: center

            block {
              width: 10px
              height: 10px
              border-radius: 50%
              background: theme.fg
            }
            block {
              width: 10px
              height: 10px
              border-radius: 50%
              background: theme.accent
            }
            block {
              width: 10px
              height: 10px
              border-radius: 50%
              background: theme.bdr
            }
          }
        }
      }
      }
    }
  }

  // Theme Builder — full right-side editor panel
  block {
    visibility: themeBuilderOpen
    position: fixed
    top: 0px
    right: 0px
    bottom: 0px
    width: responsive(300px, md: 400px)
    z-index: 60
    background: semantic.surface-raised
    border-left: borders.default
    shadow: elevation.overlay
    overflow: hidden
    layout: vertical

    // Panel header
    block {
      padding: spacing.3
      border-bottom: borders.default
      layout: horizontal, justify: between, align: center

      block {
        layout: horizontal, gap: spacing.2, align: center
        Icon(name: 'palette', size: icon.sm, color: semantic.interactive)
        text('Theme Builder') { style: type.heading-sm, color: semantic.text-primary }
      }

      Button(label: '✕', variant: 'ghost') {
        on click: cancelThemeBuilder()
      }
    }

    // ThemeBuilder editing form
    block {
      grow: true
      overflow: hidden
      layout: vertical
      ThemeBuilder()
    }

    // Panel footer: save name + actions
    block {
      padding: spacing.3
      border-top: borders.default
      background: semantic.surface
      layout: vertical, gap: spacing.2

      block {
        layout: horizontal, gap: spacing.2
        textInput(builderSaveName) {
          placeholder: 'Theme name to save as...'
          on change(value): { setBuilderSaveName(value) }
        }
        Button(label: 'Save', variant: 'primary', disabled: builderSaveName == '') {
          on click: saveBuilderTheme()
        }
      }

      Button(label: 'Cancel — restore previous theme', variant: 'secondary') {
        on click: cancelThemeBuilder()
      }
    }
  }

  // Stranger Things pulsing red glow bar (between header and content)
  block {
    visibility: themePreset == "stranger-things"
    height: 6px
    background: "linear-gradient(180deg, #E82020, #8B0000)"
    shadow: "0 4px 30px rgba(232,32,32,0.7), 0 8px 80px rgba(232,32,32,0.35), 0 2px 8px rgba(232,32,32,0.9)"
    animation: "st-glow 40s ease-in-out infinite"
  }

  // Breadcrumb navigation (Issue #18) — hidden on mobile
  block {
    max-height: responsive(0px, md: 50px)
    overflow: hidden
    background: semantic.surface-raised
    border-bottom: borders.default

    block {
      padding-y: responsive(4px, md: 8px)
      padding-x: responsive(12px, md: 20px)
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
        {heading: "Marketing", items: [
          {id: "landing2", label: "Landing Page", icon: "globe"}
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
      on select(id): {
        view = id
        mobileNavOpen = false
      }
      on collapse(c): { sidebarCollapsed = c }
      on mobileClose: closeMobileNav()
    }

    // Main content area
    block {
      grow: true
      padding: responsive(spacing.3, md: spacing.5)
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
    open: commandPaletteOpen,
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
      {id: "landing2", label: "Landing Page", group: "Marketing", icon: "globe"},
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

  } // close surface block
  } // close root wrapper block
}
