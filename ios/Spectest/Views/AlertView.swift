import SwiftUI
import SpecRuntime

@Observable
final class AlertViewModel {
  var dismissible: Any = false
  var message: Any? = nil
  var severity: Any = "info"
  var title: Any = ""
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct AlertView: View {
  @State private var vm = AlertViewModel()
  var dismissible: Any = false
  var message: Any? = nil
  var severity: Any = "info"
  var title: Any = ""
  init(dismissible: Any = false, message: Any? = nil, severity: Any = "info", title: Any = "") { self._vm = State(initialValue: AlertViewModel()); self.dismissible = dismissible; self.message = message; self.severity = severity; self.title = title }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
        Image(systemName: specIconName(specString(({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "info"
case specString("success"): return "circle-check"
case specString("warning"): return "alert-triangle"
case specString("error"): return "circle-x"
default: return "info"
} })())))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xs"))))
          .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-text")
case specString("success"): return ThemeManager.shared.color("alert-success-text")
case specString("warning"): return ThemeManager.shared.color("alert-warning-text")
case specString("error"): return ThemeManager.shared.color("alert-error-text")
default: return ThemeManager.shared.color("alert-info-text")
} })())
        VStack(spacing: CGFloat(2)) {
          Text(verbatim: specString(vm.title))
            .font(.body.bold())
            .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-text")
case specString("success"): return ThemeManager.shared.color("alert-success-text")
case specString("warning"): return ThemeManager.shared.color("alert-warning-text")
case specString("error"): return ThemeManager.shared.color("alert-error-text")
default: return ThemeManager.shared.color("alert-info-text")
} })())
          Text(verbatim: specString(vm.message))
            .font(.body.bold())
            .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-text")
case specString("success"): return ThemeManager.shared.color("alert-success-text")
case specString("warning"): return ThemeManager.shared.color("alert-warning-text")
case specString("error"): return ThemeManager.shared.color("alert-error-text")
default: return ThemeManager.shared.color("alert-info-text")
} })())
        }
        .frame(maxWidth: .infinity)
        Button(action: { /* event callback */ }) {
        HStack(alignment: .center) {
          if specEq(vm.dismissible, true) {
            Text(verbatim: specString("u00D7"))
              .font(.body.bold())
              .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-text")
case specString("success"): return ThemeManager.shared.color("alert-success-text")
case specString("warning"): return ThemeManager.shared.color("alert-warning-text")
case specString("error"): return ThemeManager.shared.color("alert-error-text")
default: return ThemeManager.shared.color("alert-info-text")
} })())
          }
        }
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
        .frame(width: CGFloat(24))
        .specFrameHeight(CGFloat(24))
        .frame(minWidth: CGFloat(24))
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
        .hoverEffect(.highlight)
        }
        .buttonStyle(.plain)
      }
      .padding(ThemeManager.shared.size("spacing-3"))
      .background(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-bg")
case specString("success"): return ThemeManager.shared.color("alert-success-bg")
case specString("warning"): return ThemeManager.shared.color("alert-warning-bg")
case specString("error"): return ThemeManager.shared.color("alert-error-bg")
default: return ThemeManager.shared.color("alert-info-bg")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("alert-radius")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.severity, severity) { vm.severity = severity }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.dismissible, dismissible) { vm.dismissible = dismissible } }
    .task(id: specPropsKey([message, severity, title, dismissible])) { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.severity, severity) { vm.severity = severity }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.dismissible, dismissible) { vm.dismissible = dismissible } }
  }
}
