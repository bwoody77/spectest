import SwiftUI
import SpecRuntime

@Observable
final class TimePickerViewModel {
  var disabled: Any = false
  var format: Any = "24"
  var label: Any = ""
  var minuteStep: Any = 1
  var value: Any = "12:00"
  var hours: Any = 12
  var minutes: Any = 0
  var ampm: Any = "AM"
  var displayHours: Any { (specEq(format, "12") ? (specEq(hours, 0) ? 12 : ((specDouble(hours) > specDouble(12)) ? (specDouble(hours) - specDouble(12)) : hours)) : hours) }
  var formattedH: Any { ((specDouble(displayHours) < specDouble(10)) ? "0\(specString(displayHours))" : "\(specString(displayHours))") }
  var formattedM: Any { ((specDouble(minutes) < specDouble(10)) ? "0\(specString(minutes))" : "\(specString(minutes))") }
  var timeString: Any { (specEq(format, "12") ? "\(specString(formattedH)):\(specString(formattedM)) \(specString(ampm))" : "\(specString(formattedH)):\(specString(formattedM))") }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func incHour() {
    hours = (specEq(format, "24") ? (specDouble(specAdd(hours, 1)) .truncatingRemainder(dividingBy: specDouble(24))) : (specDouble(specAdd(hours, 1)) .truncatingRemainder(dividingBy: specDouble(12))))
    /* event callback */
  }
  func decHour() {
    hours = (specEq(format, "24") ? (specDouble(specAdd(hours, 23)) .truncatingRemainder(dividingBy: specDouble(24))) : (specDouble(specAdd(hours, 11)) .truncatingRemainder(dividingBy: specDouble(12))))
    /* event callback */
  }
  func incMinute() {
    minutes = (specDouble(specAdd(minutes, minuteStep)) .truncatingRemainder(dividingBy: specDouble(60)))
    /* event callback */
  }
  func decMinute() {
    minutes = (specDouble(specAdd((specDouble(minutes) - specDouble(minuteStep)), 60)) .truncatingRemainder(dividingBy: specDouble(60)))
    /* event callback */
  }
  func toggleAmPm() {
    ampm = (specEq(ampm, "AM") ? "PM" : "AM")
    /* event callback */
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct TimePickerView: View {
  @State private var vm = TimePickerViewModel()
  var disabled: Any = false
  var format: Any = "24"
  var label: Any = ""
  var minuteStep: Any = 1
  var value: Any = "12:00"
  init(disabled: Any = false, format: Any = "24", label: Any = "", minuteStep: Any = 1, value: Any = "12:00") { self._vm = State(initialValue: TimePickerViewModel()); self.disabled = disabled; self.format = format; self.label = label; self.minuteStep = minuteStep; self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-2")) {
        VStack() {
          if specNeq(vm.label, "") {
            Text(verbatim: specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
        }

        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            Text(verbatim: specString("Hr"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
              Button(action: { if specEq(vm.disabled, false) {
  vm.decHour()
} }) {
              VStack() {
                Text(verbatim: specString("u25BC"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
              HStack(alignment: .center) {
                Text(verbatim: specString(vm.formattedH))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(ThemeManager.shared.size("spacing-2"))
              .frame(minWidth: CGFloat(40))
              .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              Button(action: { if specEq(vm.disabled, false) {
  vm.incHour()
} }) {
              VStack() {
                Text(verbatim: specString("u25B2"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
            }

          }

          Text(verbatim: specString(":"))
            .font(.headline.bold())
            .foregroundStyle(ThemeManager.shared.color("text-primary"))
          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            Text(verbatim: specString("Min"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
              Button(action: { if specEq(vm.disabled, false) {
  vm.decMinute()
} }) {
              VStack() {
                Text(verbatim: specString("u25BC"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
              HStack(alignment: .center) {
                Text(verbatim: specString(vm.formattedM))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(ThemeManager.shared.size("spacing-2"))
              .frame(minWidth: CGFloat(40))
              .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              Button(action: { if specEq(vm.disabled, false) {
  vm.incMinute()
} }) {
              VStack() {
                Text(verbatim: specString("u25B2"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-1"))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
            }

          }

          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            if specEq(vm.format, "12") {
              Text(verbatim: specString(" "))
                .font(.body.bold())
                .foregroundStyle(Color.clear)
            }
            Button(action: { if specEq(vm.disabled, false) {
  vm.toggleAmPm()
} }) {
            HStack(alignment: .center) {
              Text(verbatim: specString(vm.ampm))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
            }
            .padding(ThemeManager.shared.size("spacing-2"))
            .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.4 : 1)))
            .frame(minWidth: CGFloat(48))
            .frame(minHeight: CGFloat(36))
            .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
          }

        }

      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.format, format) { vm.format = format }; if !specEq(vm.minuteStep, minuteStep) { vm.minuteStep = minuteStep }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
    .task(id: specPropsKey([value, format, minuteStep, label, disabled])) { if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.format, format) { vm.format = format }; if !specEq(vm.minuteStep, minuteStep) { vm.minuteStep = minuteStep }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
  }
}
