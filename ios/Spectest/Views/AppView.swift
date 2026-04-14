import SwiftUI
import SpecRuntime

@Observable
final class AppViewModel {
  var themePreset: Any = "default"
  var layoutStyle: Any = "sidebar"
  var view: Any = "dashboard"
  var selectedTask: Any? = nil
  var sidebarCollapsed: Any = false
  var mobileNavOpen: Any = false
  var commandPaletteOpen: Any = false
  var themeDrawerOpen: Any = false
  var themeBuilderOpen: Any = false
  var builderSaveName: Any = ""
  var currentLocale: Any = getCurrentLocale()
  var isLandingPage: Any { specEq(view, "landing2") }
  var statsTotal: Any { (stats != nil ? specGet(stats, "total") : 0) }
  var statsDone: Any { (stats != nil ? specGet(stats, "done") : 0) }
  var statsInProgress: Any { (stats != nil ? specGet(stats, "inProgress") : 0) }
  var statsTodo: Any { (stats != nil ? specGet(stats, "todo") : 0) }
  var appColorScheme: Any { ((((((((((((((((specEq(themePreset, "dark") || specEq(themePreset, "geek")) || specEq(themePreset, "glass")) || specEq(themePreset, "nord")) || specEq(themePreset, "cyberpunk")) || specEq(themePreset, "dracula")) || specEq(themePreset, "ocean")) || specEq(themePreset, "monokai")) || specEq(themePreset, "retro")) || specEq(themePreset, "gruvbox")) || specEq(themePreset, "catppuccin")) || specEq(themePreset, "synthwave")) || specEq(themePreset, "rose-pine")) || specEq(themePreset, "cobalt")) || specEq(themePreset, "stranger-things")) || specEq(themePreset, "mtg")) ? "dark" : "light") }
  var fullHeight: Any { "100vh" }
  var fullWidth: Any { "100%" }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  var viewTitle: Any { ({ () -> Any in switch specString(view) {
case specString("dashboard"): return "Dashboard"
case specString("analytics"): return "Analytics"
case specString("detail"): return "Task Detail"
case specString("create"): return "Create Task"
case specString("wizard"): return "Task Wizard"
case specString("datagrid"): return "Product Catalog"
case specString("editgrid"): return "Editable Grid"
case specString("categories"): return "Categories"
case specString("team"): return "Team"
case specString("activity"): return "Activity"
case specString("notifications"): return "Notifications"
case specString("perfgrid"): return "Grid 10K"
case specString("perfsignals"): return "Signal Test"
case specString("reactivityperf"): return "Reactivity Perf"
case specString("landing2"): return "Landing Page"
case specString("themepreview"): return "Theme Preview"
case specString("charts"): return "Charts"
case specString("drag"): return "Drag & Drop"
case specString("formdemo"): return "Form Validation"
case specString("routing"): return "Routing"
case specString("mobiledemo"): return "Mobile Demo"
case specString("featuretest"): return "Feature Test (P1-P8)"
case specString("settings"): return "Settings"
default: return "App"
} })() }
  var breadcrumbSection: Any { ({ () -> Any in switch specString(view) {
case specString("dashboard"): return "Overview"
case specString("analytics"): return "Overview"
case specString("detail"): return "Tasks"
case specString("create"): return "Tasks"
case specString("wizard"): return "Tasks"
case specString("datagrid"): return "Data"
case specString("editgrid"): return "Data"
case specString("categories"): return "Data"
case specString("team"): return "People"
case specString("activity"): return "Monitoring"
case specString("notifications"): return "Monitoring"
case specString("perfgrid"): return "Performance"
case specString("perfsignals"): return "Performance"
case specString("reactivityperf"): return "Performance"
case specString("landing2"): return "Marketing"
case specString("themepreview"): return "Design"
case specString("charts"): return "Components"
case specString("drag"): return "Components"
case specString("formdemo"): return "Components"
case specString("routing"): return "Components"
case specString("mobiledemo"): return "Components"
case specString("featuretest"): return "Testing"
case specString("settings"): return "System"
default: return ""
} })() }
  var showDashboard: Any { specEq(view, "dashboard") }
  var showAnalytics: Any { specEq(view, "analytics") }
  var showTaskDetail: Any { specEq(view, "detail") }
  var showCreateTask: Any { specEq(view, "create") }
  var showTaskWizard: Any { specEq(view, "wizard") }
  var showProductCatalog: Any { specEq(view, "datagrid") }
  var showEditableGrid: Any { specEq(view, "editgrid") }
  var showCategories: Any { specEq(view, "categories") }
  var showTeam: Any { specEq(view, "team") }
  var showActivity: Any { specEq(view, "activity") }
  var showNotifications: Any { specEq(view, "notifications") }
  var showGrid10K: Any { specEq(view, "perfgrid") }
  var showSignalTest: Any { specEq(view, "perfsignals") }
  var showReactivityPerf: Any { specEq(view, "reactivityperf") }
  var showLandingPage: Any { specEq(view, "landing2") }
  var showThemePreview: Any { specEq(view, "themepreview") }
  var showCharts: Any { specEq(view, "charts") }
  var showDragDrop: Any { specEq(view, "drag") }
  var showFormValidation: Any { specEq(view, "formdemo") }
  var showRouting: Any { specEq(view, "routing") }
  var showMobileDemo: Any { specEq(view, "mobiledemo") }
  var showFeatureTestP1P8: Any { specEq(view, "featuretest") }
  var showSettings: Any { specEq(view, "settings") }
  let statsSource = DataSource(endpoint: "http://localhost:4000/api/stats", method: "GET")
  var stats: Any? { statsSource.data }
  var statsLoading: Bool { statsSource.loading }
  var statsError: String? { statsSource.error }
  func openThemeBuilder() {
    themeBuilderOpen = true
    themeDrawerOpen = false
    startBuilderPreview(themePreset)
  }
  func cancelThemeBuilder() {
    themeBuilderOpen = false
    cancelBuilderPreview()
  }
  func saveBuilderTheme() {
    saveBuilderAsTheme(builderSaveName)
    themePreset = builderSaveName
    themeBuilderOpen = false
    builderSaveName = ""
  }
  func setBuilderSaveName(_ v: Any) {
    builderSaveName = v
  }
  func applyStrangerThemes() {
    themePreset = "stranger-things"
    themeDrawerOpen = false
  }
  func setThemePreset(_ p: Any) {
    if specEq(p, "stranger-things") {
      themeDrawerOpen = false
      strangerThingsTransition(applyStrangerThemes)
    }
    if specNeq(p, "stranger-things") {
      themePreset = p
    }
  }
  func setView(_ v: Any) {
    view = v
  }
  func toggleThemeDrawer() {
    themeDrawerOpen = (!((themeDrawerOpen) as? Bool ?? false))
    themeBuilderOpen = false
  }
  func closeThemeDrawer() {
    themeDrawerOpen = false
  }
  func toggleSidebar() {
    sidebarCollapsed = (!((sidebarCollapsed) as? Bool ?? false))
    mobileNavOpen = (!((mobileNavOpen) as? Bool ?? false))
  }
  func closeMobileNav() {
    mobileNavOpen = false
  }
  func openCommandPalette() {
    commandPaletteOpen = true
  }
  func closeCommandPalette() {
    commandPaletteOpen = false
  }
  func navigateTo(_ v: Any) {
    view = v
  }
  func setLocale(_ lang: Any) {
    currentLocale = lang
    switchLocale(lang)
  }
  func setLayout(_ style: Any) {
    layoutStyle = style
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await statsSource.fetch()
  }
}

struct AppView: View {
  @State private var vm = AppViewModel()
  var body: some View {
    VStack() {
      VStack() {
        if ((!((vm.isLandingPage) as? Bool ?? false))) as? Bool ?? false {
          VStack() {
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-4")) {
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
                Button(action: { Task { @MainActor in await vm.toggleSidebar() } }) {
                  Text(specString("☰"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                Image(systemName: specIconName(specString("home")))
                  .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
                  .foregroundStyle(ThemeManager.shared.color("interactive"))
                Text(verbatim: specString("Spec Admin"))
                  .font(.title2.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Spacer(minLength: 0)
              }
              .frame(maxWidth: .infinity)

              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                Button(action: { Task { @MainActor in await vm.toggleThemeDrawer() } }) {
                  Text(specString("Theme"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
                Button(action: { Task { @MainActor in await vm.openThemeBuilder() } }) {
                  Text(specString("Build Theme"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
                  Picker("", selection: Binding(get: { specString(vm.currentLocale) }, set: { vm.currentLocale = $0 })) {
                    Text("EN").tag("en")
                    Text("ES").tag("es")
                  }
                  .pickerStyle(.segmented)
                }

                Spacer(minLength: 0)
                Button(action: { Task { @MainActor in await vm.openCommandPalette() } }) {
                  Text(specString("⌘K"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
              }
              .frame(maxWidth: .infinity)

            }
            .background(ThemeManager.shared.color("background"))
            .background(ThemeManager.shared.color("background"))
            VStack() {
              if (vm.themeDrawerOpen) as? Bool ?? false {
                HStack(alignment: .center) {
                  Text(verbatim: specString("Themes"))
                    .font(.headline.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                  Spacer(minLength: 0)
                  Button(action: { Task { @MainActor in await vm.closeThemeDrawer() } }) {
                    Text(specString("✕"))
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(.blue)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                  }
                }
                .frame(maxWidth: .infinity)
                .padding(ThemeManager.shared.size("spacing-3"))
              }
              ScrollView(.horizontal, showsIndicators: true) {
              VStack() {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: ThemeManager.shared.size("spacing-3")) {
                  ForEach(Array(specArr([["value": "gruvbox" as Any, "label": "Gruvbox" as Any, "bg": "#282828" as Any, "fg": "#EBDBB2" as Any, "accent": "#FE8019" as Any, "bdr": "#504945" as Any] as [String: Any], ["value": "shadcn" as Any, "label": "shadcn" as Any, "bg": "#fafafa" as Any, "fg": "#09090b" as Any, "accent": "#18181b" as Any, "bdr": "#e4e4e7" as Any] as [String: Any], ["value": "solarized" as Any, "label": "Solarized" as Any, "bg": "#EEE8D5" as Any, "fg": "#073642" as Any, "accent": "#2AA198" as Any, "bdr": "#93A1A1" as Any] as [String: Any], ["value": "stranger-things" as Any, "label": "Stranger Things" as Any, "bg": "#0C0808" as Any, "fg": "#F0D8D0" as Any, "accent": "#E82020" as Any, "bdr": "#3A1C1C" as Any] as [String: Any], ["value": "cartoon" as Any, "label": "Cartoon" as Any, "bg": "#fdf6ec" as Any, "fg": "#2d3748" as Any, "accent": "#2d6a4f" as Any, "bdr": "#e2d5c1" as Any] as [String: Any], ["value": "geek" as Any, "label": "Geek" as Any, "bg": "#0a0a0a" as Any, "fg": "#00ff41" as Any, "accent": "#00ff41" as Any, "bdr": "#1a3a1a" as Any] as [String: Any], ["value": "nord" as Any, "label": "Nord" as Any, "bg": "#2E3440" as Any, "fg": "#ECEFF4" as Any, "accent": "#88C0D0" as Any, "bdr": "#3B4252" as Any] as [String: Any], ["value": "illustration" as Any, "label": "Illustration" as Any, "bg": "#fff9f0" as Any, "fg": "#1a1a2e" as Any, "accent": "#52c41a" as Any, "bdr": "#e8dfd6" as Any] as [String: Any], ["value": "mtg" as Any, "label": "MTG" as Any, "bg": "#1C1712" as Any, "fg": "#E8DCC8" as Any, "accent": "#D4A836" as Any, "bdr": "#5C4A30" as Any] as [String: Any], ["value": "cyberpunk" as Any, "label": "Cyberpunk" as Any, "bg": "#0D001A" as Any, "fg": "#F0ABFC" as Any, "accent": "#FF2D95" as Any, "bdr": "#2D0050" as Any] as [String: Any], ["value": "pastel" as Any, "label": "Pastel" as Any, "bg": "#F8F6FF" as Any, "fg": "#2D2642" as Any, "accent": "#9B72CF" as Any, "bdr": "#E0D8F0" as Any] as [String: Any], ["value": "newspaper" as Any, "label": "Newspaper" as Any, "bg": "#FFFEF9" as Any, "fg": "#1A1A1A" as Any, "accent": "#8B0000" as Any, "bdr": "#D8D0C4" as Any] as [String: Any], ["value": "high-contrast" as Any, "label": "Hi-Contrast" as Any, "bg": "#FFFFFF" as Any, "fg": "#000000" as Any, "accent": "#0050D8" as Any, "bdr": "#000000" as Any] as [String: Any], ["value": "retro" as Any, "label": "Retro" as Any, "bg": "#0A0800" as Any, "fg": "#FFB000" as Any, "accent": "#FFB000" as Any, "bdr": "#3D2200" as Any] as [String: Any], ["value": "dracula" as Any, "label": "Dracula" as Any, "bg": "#282A36" as Any, "fg": "#F8F8F2" as Any, "accent": "#BD93F9" as Any, "bdr": "#44475A" as Any] as [String: Any], ["value": "sunset" as Any, "label": "Sunset" as Any, "bg": "#FFF8F1" as Any, "fg": "#1C1917" as Any, "accent": "#EA580C" as Any, "bdr": "#FFEDD5" as Any] as [String: Any], ["value": "default" as Any, "label": "Default" as Any, "bg": "#f7f7f8" as Any, "fg": "#202732" as Any, "accent": "#1677ff" as Any, "bdr": "#dce0e5" as Any] as [String: Any], ["value": "dark" as Any, "label": "Dark" as Any, "bg": "#0f172a" as Any, "fg": "#e2e8f0" as Any, "accent": "#818cf8" as Any, "bdr": "#334155" as Any] as [String: Any], ["value": "mui" as Any, "label": "MUI" as Any, "bg": "#ffffff" as Any, "fg": "#212121" as Any, "accent": "#1976d2" as Any, "bdr": "#e0e0e0" as Any] as [String: Any], ["value": "bootstrap" as Any, "label": "Bootstrap" as Any, "bg": "#ffffff" as Any, "fg": "#212529" as Any, "accent": "#0d6efd" as Any, "bdr": "#dee2e6" as Any] as [String: Any], ["value": "glass" as Any, "label": "Glass" as Any, "bg": "rgba(15,23,42,0.85)" as Any, "fg": "#e2e8f0" as Any, "accent": "#a78bfa" as Any, "bdr": "rgba(255,255,255,0.15)" as Any] as [String: Any], ["value": "sakura" as Any, "label": "Sakura" as Any, "bg": "#FFF5F5" as Any, "fg": "#1A1A2E" as Any, "accent": "#E11D48" as Any, "bdr": "#FECDD3" as Any] as [String: Any], ["value": "ocean" as Any, "label": "Ocean" as Any, "bg": "#0C1929" as Any, "fg": "#CBD5E1" as Any, "accent": "#2DD4BF" as Any, "bdr": "#1E3A5F" as Any] as [String: Any], ["value": "lavender" as Any, "label": "Lavender" as Any, "bg": "#F5F3FF" as Any, "fg": "#1E1B4B" as Any, "accent": "#7C3AED" as Any, "bdr": "#DDD6FE" as Any] as [String: Any], ["value": "brutalist" as Any, "label": "Brutalist" as Any, "bg": "#FFFFFF" as Any, "fg": "#000000" as Any, "accent": "#000000" as Any, "bdr": "#000000" as Any] as [String: Any], ["value": "monokai" as Any, "label": "Monokai" as Any, "bg": "#272822" as Any, "fg": "#F8F8F2" as Any, "accent": "#F92672" as Any, "bdr": "#3E3D32" as Any] as [String: Any], ["value": "earth" as Any, "label": "Earth" as Any, "bg": "#F5F0EB" as Any, "fg": "#292524" as Any, "accent": "#B45309" as Any, "bdr": "#D6CFC7" as Any] as [String: Any], ["value": "catppuccin" as Any, "label": "Catppuccin" as Any, "bg": "#1E1E2E" as Any, "fg": "#CDD6F4" as Any, "accent": "#CBA6F7" as Any, "bdr": "#45475A" as Any] as [String: Any], ["value": "synthwave" as Any, "label": "Synthwave" as Any, "bg": "#241B2F" as Any, "fg": "#F0E8FF" as Any, "accent": "#FF7AC6" as Any, "bdr": "#463868" as Any] as [String: Any], ["value": "rose-pine" as Any, "label": "Rosé Pine" as Any, "bg": "#191724" as Any, "fg": "#E0DEF4" as Any, "accent": "#EBBCBA" as Any, "bdr": "#3A3650" as Any] as [String: Any], ["value": "cobalt" as Any, "label": "Cobalt" as Any, "bg": "#15232D" as Any, "fg": "#E1EFFF" as Any, "accent": "#FFC600" as Any, "bdr": "#1E4263" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, theme in
                    Button(action: { vm.setThemePreset(specGet(theme, "value")) }) {
                    VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                      VStack() {
                      }
                      .specFrameHeight(CGFloat(4))
                      .background(Color(hex: specGet(theme, "accent") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: CGFloat(2)))
                      Text(verbatim: specString("Aa"))
                        .font(.body.bold())
                        .foregroundStyle(Color(hex: specGet(theme, "fg") as? String ?? "transparent"))
                      Text(verbatim: specString(specGet(theme, "label")))
                        .font(.callout.bold())
                        .foregroundStyle(Color(hex: specGet(theme, "fg") as? String ?? "transparent"))
                      HStack(alignment: .center, spacing: CGFloat(4)) {
                        VStack() {
                        }
                        .frame(width: CGFloat(10))
                        .specFrameHeight(CGFloat(10))
                        .background(Color(hex: specGet(theme, "fg") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
                        VStack() {
                        }
                        .frame(width: CGFloat(10))
                        .specFrameHeight(CGFloat(10))
                        .background(Color(hex: specGet(theme, "accent") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
                        VStack() {
                        }
                        .frame(width: CGFloat(10))
                        .specFrameHeight(CGFloat(10))
                        .background(Color(hex: specGet(theme, "bdr") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
                      }

                    }
                    .padding(ThemeManager.shared.size("spacing-2"))
                    .background(Color(hex: specGet(theme, "bg") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
                    }
                    .buttonStyle(.plain)
                  }
                }

              }
              }
              .padding(ThemeManager.shared.size("spacing-4"))
              .frame(maxWidth: .infinity)
            }
            .background(ThemeManager.shared.color("surface-raised"))
            .frame(width: CGFloat(0))
            .background(ThemeManager.shared.color("surface-raised"))
            VStack() {
              if (vm.themeBuilderOpen) as? Bool ?? false {
                HStack(alignment: .center) {
                  HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                    Image(systemName: specIconName(specString("palette")))
                      .font(.system(size: specPx(ThemeManager.shared.resolve("icon-sm"))))
                      .foregroundStyle(ThemeManager.shared.color("interactive"))
                    Text(verbatim: specString("Theme Builder"))
                      .font(.headline.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-primary"))
                    Spacer(minLength: 0)
                  }
                  .frame(maxWidth: .infinity)

                  Spacer(minLength: 0)
                  Button(action: { Task { @MainActor in await vm.cancelThemeBuilder() } }) {
                    Text(specString("✕"))
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(.blue)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                  }
                }
                .frame(maxWidth: .infinity)
                .padding(ThemeManager.shared.size("spacing-3"))
              }
              VStack() {
                ThemeBuilderView()
              }
              .frame(maxWidth: .infinity)
              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  TextField("", text: Binding(get: { vm.builderSaveName as? String ?? "" }, set: { vm.builderSaveName = $0 }))
                    .textFieldStyle(.roundedBorder)
                  Button(action: { Task { @MainActor in await vm.saveBuilderTheme() } }) {
                    Text(specString("Save"))
                      .font(.subheadline.weight(.semibold))
                      .foregroundStyle(.white)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                  }
                  .disabled(specEq(vm.builderSaveName, "") as? Bool ?? false)
                }

                Button(action: { Task { @MainActor in await vm.cancelThemeBuilder() } }) {
                  Text(specString("Cancel — restore previous theme"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                }
              }
              .padding(ThemeManager.shared.size("spacing-3"))
              .background(ThemeManager.shared.color("surface"))
              .background(ThemeManager.shared.color("surface"))
            }
            .background(ThemeManager.shared.color("surface-raised"))
            .frame(width: CGFloat(0))
            .background(ThemeManager.shared.color("surface-raised"))
            VStack() {
              if specEq(vm.themePreset, "stranger-things") {
              }
            }
            .background(LinearGradient(colors: [Color(hex: "#E82020"), Color(hex: "#8B0000")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .specFrameHeight(CGFloat(6))
            .background(LinearGradient(colors: [Color(hex: "#E82020"), Color(hex: "#8B0000")], startPoint: .topLeading, endPoint: .bottomTrailing))
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
              Image(systemName: specIconName(specString("layout")))
                .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xs"))))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              Picker("", selection: Binding(get: { specString(vm.layoutStyle) }, set: { vm.layoutStyle = $0 })) {
                Text("Sidebar").tag("sidebar")
                Text("Header").tag("header")
                Text("Tabs").tag("tabs")
              }
              .pickerStyle(.segmented)
            }
            .padding(ThemeManager.shared.size("spacing-2"))
            .padding(.leading, ThemeManager.shared.size("spacing-3"))
            .padding(.trailing, ThemeManager.shared.size("spacing-3"))
            .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-lg")))
            VStack() {
              if specEq(vm.layoutStyle, "sidebar") {
                SidebarLayoutView(activeRoute: vm.view, breadcrumbSection: vm.breadcrumbSection, breadcrumbTitle: vm.viewTitle, items: vm.navItems, sections: vm.navSections)
              }
            }

            VStack() {
              if specEq(vm.layoutStyle, "header") {
                HeaderLayoutView(activeRoute: vm.view, sections: vm.navSections)
              }
            }

            VStack() {
              if specEq(vm.layoutStyle, "tabs") {
                TabLayoutView(activeRoute: vm.view, items: vm.navItems)
              }
            }

          }
          .background(ThemeManager.shared.color("surface"))
          .background(ThemeManager.shared.color("surface"))
          .frame(maxWidth: .infinity)
        }
      }
      .background(ThemeManager.shared.color("gradient-app-background"))
      .specFrameHeight(specPx(vm.fullHeight))
      .background(ThemeManager.shared.color("gradient-app-background"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
  }
}
