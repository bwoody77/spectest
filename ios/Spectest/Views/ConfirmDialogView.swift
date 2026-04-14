import SwiftUI
import SpecRuntime

@Observable
final class ConfirmDialogViewModel {
  var cancelLabel: Any = "Cancel"
  var confirmLabel: Any = "Confirm"
  var destructive: Any = false
  var message: Any = ""
  var open: Any = false
  var title: Any = "Confirm"
  var showing: Any = false
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func doOpen() {
    if (showing) as? Bool ?? false {
      return
    }
    showing = true
    // unsupported: builtin-call
    // unsupported: builtin-call
  }
  func doClose() {
    if ((!((showing) as? Bool ?? false))) as? Bool ?? false {
      return
    }
    showing = false
    // unsupported: builtin-call
    // unsupported: builtin-call
  }
  func confirm() {
    /* event callback */
    doClose()
  }
  func cancel() {
    /* event callback */
    doClose()
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ConfirmDialogView: View {
  @State private var vm = ConfirmDialogViewModel()
  var cancelLabel: Any = "Cancel"
  var confirmLabel: Any = "Confirm"
  var destructive: Any = false
  var message: Any = ""
  var open: Any = false
  var title: Any = "Confirm"
  init(cancelLabel: Any = "Cancel", confirmLabel: Any = "Confirm", destructive: Any = false, message: Any = "", open: Any = false, title: Any = "Confirm") { self._vm = State(initialValue: ConfirmDialogViewModel()); self.cancelLabel = cancelLabel; self.confirmLabel = confirmLabel; self.destructive = destructive; self.message = message; self.open = open; self.title = title }
  var body: some View {
    VStack() {
      Color.clear.frame(width: 0, height: 0)
        .overlay {
          if (vm.showing) as? Bool ?? false {
            ZStack {
              Color.black.opacity(0.15).ignoresSafeArea()
                .onTapGesture {
                  vm.cancel()
                }
              VStack(spacing: ThemeManager.shared.size("spacing-3")) {
                Text(verbatim: specString(vm.title))
                  .font(.headline.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
                Text(verbatim: specString(vm.message))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Button(action: { Task { @MainActor in await vm.cancel() } }) {
                    Text(specString(vm.cancelLabel))
                      .font(.subheadline.weight(.medium))
                      .foregroundStyle(.blue)
                      .padding(.horizontal, 16)
                      .padding(.vertical, 8)
                      .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
                  }
                  VStack() {
                    if specEq(vm.destructive, false) {
                      Button(action: { Task { @MainActor in await vm.confirm() } }) {
                        Text(specString(vm.confirmLabel))
                          .font(.subheadline.weight(.semibold))
                          .foregroundStyle(.white)
                          .padding(.horizontal, 16)
                          .padding(.vertical, 8)
                          .background(.blue, in: RoundedRectangle(cornerRadius: 8))
                      }
                    }
                  }

                  VStack() {
                    if specEq(vm.destructive, true) {
                      Button(action: { Task { @MainActor in await vm.confirm() } }) {
                        Text(specString(vm.confirmLabel))
                          .font(.subheadline.weight(.semibold))
                          .foregroundStyle(specString("destructive") == "primary" ? .white : .blue)
                          .padding(.horizontal, 16)
                          .padding(.vertical, 8)
                          .background(specString("destructive") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
                      }
                    }
                  }

                }

              }
              .padding(ThemeManager.shared.size("spacing-5"))
              .frame(width: CGFloat(440))
              .frame(maxWidth: CGFloat(0))
              .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            }
          }
        }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.confirmLabel, confirmLabel) { vm.confirmLabel = confirmLabel }; if !specEq(vm.cancelLabel, cancelLabel) { vm.cancelLabel = cancelLabel }; if !specEq(vm.destructive, destructive) { vm.destructive = destructive } }
    .task(id: specPropsKey([open, title, message, confirmLabel, cancelLabel, destructive])) { if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.confirmLabel, confirmLabel) { vm.confirmLabel = confirmLabel }; if !specEq(vm.cancelLabel, cancelLabel) { vm.cancelLabel = cancelLabel }; if !specEq(vm.destructive, destructive) { vm.destructive = destructive } }
  }
}
