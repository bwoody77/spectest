import SwiftUI
import SpecRuntime

@Observable
final class StatsBarViewModel {
  var done: Any? = nil
  var inProgress: Any? = nil
  var todo: Any? = nil
  var total: Any? = nil
  var donePercent: Any { ((specDouble(total) > specDouble(0)) ? (specDouble((specDouble(done) * specDouble(100))) / specDouble(total)) : 0) }
  var inProgressPercent: Any { ((specDouble(total) > specDouble(0)) ? (specDouble((specDouble(inProgress) * specDouble(100))) / specDouble(total)) : 0) }
  var todoPercent: Any { ((specDouble(total) > specDouble(0)) ? (specDouble((specDouble(todo) * specDouble(100))) / specDouble(total)) : 0) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct StatsBarView: View {
  @State private var vm = StatsBarViewModel()
  var done: Any? = nil
  var inProgress: Any? = nil
  var todo: Any? = nil
  var total: Any? = nil
  init(done: Any? = nil, inProgress: Any? = nil, todo: Any? = nil, total: Any? = nil) { self._vm = State(initialValue: StatsBarViewModel()); self.done = done; self.inProgress = inProgress; self.todo = todo; self.total = total }
  var body: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-4")) {
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("list")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
          Text(verbatim: specString("Total Tasks"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading, spacing: 4) {
          Text(specString("\(specString(vm.total))")).font(.system(size: 32, weight: .bold, design: .rounded))
          Text(specString("tasks")).font(.subheadline).foregroundStyle(.secondary)
        }
      }
      .padding(ThemeManager.shared.size("spacing-4"))
      .background(ThemeManager.shared.color("gradient-stat-primary-subtle"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .hoverEffect(.highlight)
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("success"))
          Text(verbatim: specString("Completed"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading, spacing: 4) {
          Text(specString("\(specString(vm.done))")).font(.system(size: 32, weight: .bold, design: .rounded))
          Text(specString("done")).font(.subheadline).foregroundStyle(.secondary)
        }
        ProgressView(value: (vm.donePercent as? Double ?? 0) / 100.0)
          .tint(.accentColor)
      }
      .padding(ThemeManager.shared.size("spacing-4"))
      .background(ThemeManager.shared.color("gradient-stat-success-subtle"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .hoverEffect(.highlight)
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("loader")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("warning"))
          Text(verbatim: specString("In Progress"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading, spacing: 4) {
          Text(specString("\(specString(vm.inProgress))")).font(.system(size: 32, weight: .bold, design: .rounded))
          Text(specString("active")).font(.subheadline).foregroundStyle(.secondary)
        }
        ProgressView(value: (vm.inProgressPercent as? Double ?? 0) / 100.0)
          .tint(.accentColor)
      }
      .padding(ThemeManager.shared.size("spacing-4"))
      .background(ThemeManager.shared.color("gradient-stat-warning-subtle"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .hoverEffect(.highlight)
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          Image(systemName: specIconName(specString("circle")))
            .font(.system(size: specPx(ThemeManager.shared.resolve("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("text-muted"))
          Text(verbatim: specString("Todo"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading, spacing: 4) {
          Text(specString("\(specString(vm.todo))")).font(.system(size: 32, weight: .bold, design: .rounded))
          Text(specString("remaining")).font(.subheadline).foregroundStyle(.secondary)
        }
        ProgressView(value: (vm.todoPercent as? Double ?? 0) / 100.0)
          .tint(.accentColor)
      }
      .padding(ThemeManager.shared.size("spacing-4"))
      .background(ThemeManager.shared.color("gradient-stat-neutral-subtle"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .hoverEffect(.highlight)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.total, total) { vm.total = total }; if !specEq(vm.done, done) { vm.done = done }; if !specEq(vm.inProgress, inProgress) { vm.inProgress = inProgress }; if !specEq(vm.todo, todo) { vm.todo = todo } }
    .task(id: specPropsKey([total, done, inProgress, todo])) { if !specEq(vm.total, total) { vm.total = total }; if !specEq(vm.done, done) { vm.done = done }; if !specEq(vm.inProgress, inProgress) { vm.inProgress = inProgress }; if !specEq(vm.todo, todo) { vm.todo = todo } }
  }
}
