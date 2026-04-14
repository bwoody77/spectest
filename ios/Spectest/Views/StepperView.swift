import SwiftUI
import SpecRuntime

@Observable
final class StepperViewModel {
  var activeStep: Any = 0
  var allowBack: Any = true
  var orientation: Any = "horizontal"
  var steps: Any = [] as [Any]
  var stepCount: Any { specLength(steps) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct StepperView: View {
  @State private var vm = StepperViewModel()
  var activeStep: Any = 0
  var allowBack: Any = true
  var orientation: Any = "horizontal"
  var steps: Any = [] as [Any]
  init(activeStep: Any = 0, allowBack: Any = true, orientation: Any = "horizontal", steps: Any = [] as [Any]) { self._vm = State(initialValue: StepperViewModel()); self.activeStep = activeStep; self.allowBack = allowBack; self.orientation = orientation; self.steps = steps }
  var body: some View {
    VStack() {
      HStack(alignment: .center) {
        if specEq(vm.orientation, "horizontal") {
          ForEach(Array(specArr(vm.steps).enumerated()), id: \.offset) { i, step in
            HStack(alignment: .center) {
              Button(action: { if ((vm.allowBack) as? Bool ?? false && (specDouble(i) < specDouble(vm.activeStep))) {
  /* event callback */
} }) {
              VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                HStack(alignment: .center) {
                  Text(verbatim: specString(({ () -> Any in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return "u2713"
default: return "\(specString(specAdd(i, 1)))"
} })()))
                    .font(.body.bold())
                    .foregroundStyle(({ () -> Color in switch specString(true) {
case specString((specDouble(i) <= specDouble(vm.activeStep))): return ThemeManager.shared.color("semantic.background")
default: return ThemeManager.shared.color("text-secondary")
} })())
                }
                .frame(width: CGFloat(32))
                .specFrameHeight(CGFloat(32))
                .frame(minWidth: CGFloat(32))
                .background(({ () -> Color in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return Color(hex: "#22c55e")
case specString(specEq(i, vm.activeStep)): return ThemeManager.shared.color("interactive")
default: return ThemeManager.shared.color("surface-raised")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
                Text(verbatim: specString(specGet(step, "label")))
                  .font(.body.bold())
                  .foregroundStyle(({ () -> Color in switch specString(true) {
case specString(specEq(i, vm.activeStep)): return ThemeManager.shared.color("text-primary")
case specString((specDouble(i) < specDouble(vm.activeStep))): return Color(hex: "#22c55e")
default: return ThemeManager.shared.color("text-tertiary")
} })())
              }

              }
              .buttonStyle(.plain)
              VStack() {
                if (specDouble(i) < specDouble((specDouble(vm.stepCount) - specDouble(1)))) {
                }
              }
              .background(((specDouble(i) < specDouble(vm.activeStep)) ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
              .specFrameHeight(CGFloat(2))
              .frame(minHeight: CGFloat(2))
              .background(((specDouble(i) < specDouble(vm.activeStep)) ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
              .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
          }
        }
      }

      VStack() {
        if specEq(vm.orientation, "vertical") {
          ForEach(Array(specArr(vm.steps).enumerated()), id: \.offset) { i, step in
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
              VStack() {
                Button(action: { if ((vm.allowBack) as? Bool ?? false && (specDouble(i) < specDouble(vm.activeStep))) {
  /* event callback */
} }) {
                HStack(alignment: .center) {
                  Text(verbatim: specString(({ () -> Any in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return "u2713"
default: return "\(specString(specAdd(i, 1)))"
} })()))
                    .font(.body.bold())
                    .foregroundStyle(({ () -> Color in switch specString(true) {
case specString((specDouble(i) <= specDouble(vm.activeStep))): return ThemeManager.shared.color("semantic.background")
default: return ThemeManager.shared.color("text-secondary")
} })())
                }
                .frame(width: CGFloat(32))
                .specFrameHeight(CGFloat(32))
                .frame(minWidth: CGFloat(32))
                .background(({ () -> Color in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return Color(hex: "#22c55e")
case specString(specEq(i, vm.activeStep)): return ThemeManager.shared.color("interactive")
default: return ThemeManager.shared.color("surface-raised")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
                }
                .buttonStyle(.plain)
                VStack() {
                  if (specDouble(i) < specDouble((specDouble(vm.stepCount) - specDouble(1)))) {
                  }
                }
                .background(((specDouble(i) < specDouble(vm.activeStep)) ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
                .frame(width: CGFloat(2))
                .frame(minHeight: CGFloat(24))
                .background(((specDouble(i) < specDouble(vm.activeStep)) ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
                .frame(maxWidth: .infinity)
              }
              .frame(width: CGFloat(32))
              .frame(minWidth: CGFloat(32))
              VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                Text(verbatim: specString(specGet(step, "label")))
                  .font(.body.bold())
                  .foregroundStyle(({ () -> Color in switch specString(true) {
case specString(specEq(i, vm.activeStep)): return ThemeManager.shared.color("text-primary")
case specString((specDouble(i) < specDouble(vm.activeStep))): return Color(hex: "#22c55e")
default: return ThemeManager.shared.color("text-tertiary")
} })())
                VStack() {
                  if specGet(step, "description") != nil {
                    Text(verbatim: specString(specGet(step, "description")))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  }
                }

              }
              .padding(ThemeManager.shared.size("spacing-2"))
            }

          }
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.steps, steps) { vm.steps = steps }; if !specEq(vm.activeStep, activeStep) { vm.activeStep = activeStep }; if !specEq(vm.orientation, orientation) { vm.orientation = orientation }; if !specEq(vm.allowBack, allowBack) { vm.allowBack = allowBack } }
    .task(id: specPropsKey([steps, activeStep, orientation, allowBack])) { if !specEq(vm.steps, steps) { vm.steps = steps }; if !specEq(vm.activeStep, activeStep) { vm.activeStep = activeStep }; if !specEq(vm.orientation, orientation) { vm.orientation = orientation }; if !specEq(vm.allowBack, allowBack) { vm.allowBack = allowBack } }
  }
}
