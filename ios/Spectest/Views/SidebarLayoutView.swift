import SwiftUI
import SpecRuntime

@Observable
final class SidebarLayoutViewModel {
  var activeRoute: Any = ""
  var breadcrumbSection: Any = ""
  var breadcrumbTitle: Any = ""
  var items: Any = [] as [Any]
  var sections: Any = [] as [Any]
  var sidebarCollapsed: Any = false
  var commandPaletteOpen: Any = false
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct SidebarLayoutView: View {
  @State private var vm = SidebarLayoutViewModel()
  var activeRoute: Any = ""
  var breadcrumbSection: Any = ""
  var breadcrumbTitle: Any = ""
  var items: Any = [] as [Any]
  var sections: Any = [] as [Any]
  init(activeRoute: Any = "", breadcrumbSection: Any = "", breadcrumbTitle: Any = "", items: Any = [] as [Any], sections: Any = [] as [Any]) { self._vm = State(initialValue: SidebarLayoutViewModel()); self.activeRoute = activeRoute; self.breadcrumbSection = breadcrumbSection; self.breadcrumbTitle = breadcrumbTitle; self.items = items; self.sections = sections }
  var body: some View {
    HStack(alignment: .center) {
      SidebarView(activeItem: vm.activeRoute, collapsed: vm.sidebarCollapsed, sections: vm.sections)
      VStack() {
        HStack(alignment: .center) {
          HStack(spacing: 4) {
            ForEach(Array(([["id": "home" as Any, "label": "Home" as Any] as [String: Any], ["id": vm.activeRoute as Any, "label": vm.breadcrumbSection as Any] as [String: Any], ["id": vm.activeRoute as Any, "label": vm.breadcrumbTitle as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { idx, crumb in
              if idx > 0 {
                Image(systemName: "chevron.right").font(.caption2).foregroundStyle(.tertiary)
              }
              Text(specString((crumb as? [String: Any])?["label"] ?? crumb))
                .font(.subheadline)
                .foregroundStyle(idx < ([["id": "home" as Any, "label": "Home" as Any] as [String: Any], ["id": vm.activeRoute as Any, "label": vm.breadcrumbSection as Any] as [String: Any], ["id": vm.activeRoute as Any, "label": vm.breadcrumbTitle as Any] as [String: Any]] as [Any] as? [Any] ?? []).count - 1 ? .secondary : .primary)
            }
          }
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
            Button(action: { Task { @MainActor in await vm.commandPaletteOpen = true } }) {
              Text(specString(""))
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
          }

          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(ThemeManager.shared.size("spacing-3"))
        ScrollView(.horizontal, showsIndicators: true) {
        VStack() {
          // slot
        }
        }
        .padding(ThemeManager.shared.size("spacing-4"))
        .frame(maxWidth: .infinity)
      }
      .frame(maxWidth: .infinity)
      Spacer(minLength: 0)
      CommandPaletteView(commands: vm.items, open: vm.commandPaletteOpen)
    }
    .frame(maxWidth: .infinity)
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.activeRoute, activeRoute) { vm.activeRoute = activeRoute }; if !specEq(vm.sections, sections) { vm.sections = sections }; if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.breadcrumbSection, breadcrumbSection) { vm.breadcrumbSection = breadcrumbSection }; if !specEq(vm.breadcrumbTitle, breadcrumbTitle) { vm.breadcrumbTitle = breadcrumbTitle } }
    .task(id: specPropsKey([activeRoute, sections, items, breadcrumbSection, breadcrumbTitle])) { if !specEq(vm.activeRoute, activeRoute) { vm.activeRoute = activeRoute }; if !specEq(vm.sections, sections) { vm.sections = sections }; if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.breadcrumbSection, breadcrumbSection) { vm.breadcrumbSection = breadcrumbSection }; if !specEq(vm.breadcrumbTitle, breadcrumbTitle) { vm.breadcrumbTitle = breadcrumbTitle } }
  }
}
