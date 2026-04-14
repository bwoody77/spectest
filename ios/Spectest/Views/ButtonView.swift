import SwiftUI
import SpecRuntime

@Observable
final class ButtonViewModel {
  var disabled: Any = false
  var label: Any? = nil
  var loading: Any = false
  var pressed: Any = false
  var size: Any = "md"
  var variant: Any = "primary"
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ButtonView: View {
  @State private var vm = ButtonViewModel()
  var disabled: Any = false
  var label: Any? = nil
  var loading: Any = false
  var pressed: Any = false
  var size: Any = "md"
  var variant: Any = "primary"
  init(disabled: Any = false, label: Any? = nil, loading: Any = false, pressed: Any = false, size: Any = "md", variant: Any = "primary") { self._vm = State(initialValue: ButtonViewModel()); self.disabled = disabled; self.label = label; self.loading = loading; self.pressed = pressed; self.size = size; self.variant = variant }
  var body: some View {
    VStack() {
      Button(action: {  }) {
        Text(verbatim: specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(({ () -> Color in switch specString(vm.variant) {
case specString("primary"): return ThemeManager.shared.color("btn-primary-color")
case specString("secondary"): return ThemeManager.shared.color("btn-secondary-color")
case specString("ghost"): return ThemeManager.shared.color("btn-ghost-color")
case specString("destructive"): return ThemeManager.shared.color("btn-destructive-color")
default: return ThemeManager.shared.color("btn-primary-color")
} })())
      }
      .padding(.leading, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "8px"
case specString("lg"): return "24px"
default: return ThemeManager.shared.resolve("btn-paddingH")
} })()))
      .padding(.trailing, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "8px"
case specString("lg"): return "24px"
default: return ThemeManager.shared.resolve("btn-paddingH")
} })()))
      .padding(.top, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "4px"
case specString("lg"): return "12px"
default: return ThemeManager.shared.resolve("btn-paddingV")
} })()))
      .padding(.bottom, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "4px"
case specString("lg"): return "12px"
default: return ThemeManager.shared.resolve("btn-paddingV")
} })()))
      .opacity(specPx(({ () -> Any in switch specString(vm.loading) {
case specString(true): return 0.7
default: return ({ () -> Any in switch specString(vm.disabled) {
case specString(true): return 0.5
default: return 1
} })()
} })()))
      .background(({ () -> Color in switch specString(vm.pressed) {
case specString(true): return ({ () -> Color in switch specString(vm.variant) {
case specString("primary"): return ThemeManager.shared.color("btn-primary-hover")
case specString("secondary"): return ThemeManager.shared.color("btn-secondary-hover")
case specString("ghost"): return ThemeManager.shared.color("btn-ghost-hover")
case specString("destructive"): return ThemeManager.shared.color("btn-destructive-hover")
default: return ThemeManager.shared.color("btn-primary-hover")
} })()
default: return ({ () -> Color in switch specString(vm.variant) {
case specString("primary"): return ThemeManager.shared.color("btn-primary-bg")
case specString("secondary"): return ThemeManager.shared.color("btn-secondary-bg")
case specString("ghost"): return Color.clear
case specString("destructive"): return ThemeManager.shared.color("btn-destructive-bg")
default: return ThemeManager.shared.color("btn-primary-bg")
} })()
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("btn-radius")))
      .hoverEffect(.highlight)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.variant, variant) { vm.variant = variant }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.loading, loading) { vm.loading = loading }; if !specEq(vm.pressed, pressed) { vm.pressed = pressed }; if !specEq(vm.size, size) { vm.size = size } }
    .task(id: specPropsKey([label, variant, disabled, loading, pressed, size])) { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.variant, variant) { vm.variant = variant }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.loading, loading) { vm.loading = loading }; if !specEq(vm.pressed, pressed) { vm.pressed = pressed }; if !specEq(vm.size, size) { vm.size = size } }
  }
}
