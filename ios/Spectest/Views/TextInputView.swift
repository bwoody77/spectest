import SwiftUI
import SpecRuntime

@Observable
final class TextInputViewModel {
  var disabled: Any = false
  var error: Any = false
  var errorMessage: Any = ""
  var label: Any = ""
  var placeholder: Any = ""
  var prefix: Any = ""
  var readonly: Any = false
  var suffix: Any = ""
  var type: Any = "text"
  var value: Any = ""
  var focused: Any = false
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func handleFocus() {
    focused = true
  }
  func handleBlur() {
    focused = false
    /* event callback */
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct TextInputView: View {
  @State private var vm = TextInputViewModel()
  var disabled: Any = false
  var error: Any = false
  var errorMessage: Any = ""
  var label: Any = ""
  var placeholder: Any = ""
  var prefix: Any = ""
  var readonly: Any = false
  var suffix: Any = ""
  var type: Any = "text"
  var value: Any = ""
  init(disabled: Any = false, error: Any = false, errorMessage: Any = "", label: Any = "", placeholder: Any = "", prefix: Any = "", readonly: Any = false, suffix: Any = "", type: Any = "text", value: Any = "") { self._vm = State(initialValue: TextInputViewModel()); self.disabled = disabled; self.error = error; self.errorMessage = errorMessage; self.label = label; self.placeholder = placeholder; self.prefix = prefix; self.readonly = readonly; self.suffix = suffix; self.type = type; self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(6)) {
        VStack() {
          if specNeq(vm.label, "") {
            Text(verbatim: specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
        }

        HStack(alignment: .center, spacing: CGFloat(8)) {
          VStack() {
            if specNeq(vm.prefix, "") {
              Text(verbatim: specString(vm.prefix))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            }
          }

          VStack() {
            if specNeq(vm.type, "textarea") {
              TextField("", text: Binding(get: { vm.value as? String ?? "" }, set: { vm.value = $0 }))
                .textFieldStyle(.roundedBorder)
            }
          }
          .frame(maxWidth: .infinity)
          VStack() {
            if specEq(vm.type, "textarea") {
              TextEditor(text: Binding(get: { vm.value as? String ?? "" }, set: { vm.value = $0 }))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.separator)))
            }
          }
          .frame(maxWidth: .infinity)
          VStack() {
            if specNeq(vm.suffix, "") {
              Text(verbatim: specString(vm.suffix))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            }
          }

        }
        .padding(ThemeManager.shared.size("spacing-2"))
        .background(ThemeManager.shared.color("input-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("input-radius")))
        VStack() {
          if specEq(vm.error, true) {
            Text(verbatim: specString(vm.errorMessage))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("destructive"))
          }
        }

      }
      .opacity(specPx(({ () -> Any in switch specString(vm.disabled) {
case specString(true): return 0.5
default: return 1
} })()))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.type, type) { vm.type = type }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.readonly, readonly) { vm.readonly = readonly }; if !specEq(vm.prefix, prefix) { vm.prefix = prefix }; if !specEq(vm.suffix, suffix) { vm.suffix = suffix }; if !specEq(vm.error, error) { vm.error = error }; if !specEq(vm.errorMessage, errorMessage) { vm.errorMessage = errorMessage } }
    .task(id: specPropsKey([type, label, placeholder, value, disabled, readonly, prefix, suffix, error, errorMessage])) { if !specEq(vm.type, type) { vm.type = type }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.readonly, readonly) { vm.readonly = readonly }; if !specEq(vm.prefix, prefix) { vm.prefix = prefix }; if !specEq(vm.suffix, suffix) { vm.suffix = suffix }; if !specEq(vm.error, error) { vm.error = error }; if !specEq(vm.errorMessage, errorMessage) { vm.errorMessage = errorMessage } }
  }
}
