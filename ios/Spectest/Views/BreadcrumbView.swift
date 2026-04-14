import SwiftUI
import SpecRuntime

@Observable
final class BreadcrumbViewModel {
  var items: Any? = nil
  var maxVisible: Any = 0
  var separator: Any = "/"
  var expanded: Any = false
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func expand() {
    expanded = true
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct BreadcrumbView: View {
  @State private var vm = BreadcrumbViewModel()
  var items: Any? = nil
  var maxVisible: Any = 0
  var separator: Any = "/"
  init(items: Any? = nil, maxVisible: Any = 0, separator: Any = "/") { self._vm = State(initialValue: BreadcrumbViewModel()); self.items = items; self.maxVisible = maxVisible; self.separator = separator }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(4)) {
        ForEach(Array(specArr(vm.items).enumerated()), id: \.offset) { index, item in
          VStack() {
            if ((specDouble(index) > specDouble(0)) && (((((vm.expanded) as? Bool ?? false || specEq(vm.maxVisible, 0)) || (specDouble(specLength(vm.items)) <= specDouble(vm.maxVisible))) || specEq(index, 1)) || (specDouble(index) >= specDouble(specAdd((specDouble(specLength(vm.items)) - specDouble(vm.maxVisible)), 1))))) {
              Text(verbatim: specString(vm.separator))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            }
          }

          Button(action: { vm.expand() }) {
          VStack() {
            if (((((!((vm.expanded) as? Bool ?? false))) as? Bool ?? false && (specDouble(vm.maxVisible) > specDouble(0))) && (specDouble(specLength(vm.items)) > specDouble(vm.maxVisible))) && specEq(index, 1)) {
              Text(verbatim: specString("u2026"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("interactive"))
            }
          }
          .hoverEffect(.highlight)
          }
          .buttonStyle(.plain)
          Button(action: { /* event callback */ }) {
          VStack() {
            if (specNeq(index, (specDouble(specLength(vm.items)) - specDouble(1))) && (((((vm.expanded) as? Bool ?? false || specEq(vm.maxVisible, 0)) || (specDouble(specLength(vm.items)) <= specDouble(vm.maxVisible))) || specEq(index, 0)) || (specDouble(index) >= specDouble(specAdd((specDouble(specLength(vm.items)) - specDouble(vm.maxVisible)), 1))))) {
              Text(verbatim: specString(specGet(item, "label")))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("interactive"))
            }
          }
          .hoverEffect(.highlight)
          }
          .buttonStyle(.plain)
          VStack() {
            if specEq(index, (specDouble(specLength(vm.items)) - specDouble(1))) {
              Text(verbatim: specString(specGet(item, "label")))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }
          }

        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.separator, separator) { vm.separator = separator }; if !specEq(vm.maxVisible, maxVisible) { vm.maxVisible = maxVisible } }
    .task(id: specPropsKey([items, separator, maxVisible])) { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.separator, separator) { vm.separator = separator }; if !specEq(vm.maxVisible, maxVisible) { vm.maxVisible = maxVisible } }
  }
}
