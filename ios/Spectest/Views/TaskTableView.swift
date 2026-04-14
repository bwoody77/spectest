import SwiftUI
import SpecRuntime

@Observable
final class TaskTableViewModel {
  var selectedTask: Any? = nil
  var view: Any? = nil
  var filter: Any = "all"
  var taskList: Any { (tasks != nil ? tasks : [] as [Any]) }
  var filteredTasks: Any { (specEq(filter, "all") ? taskList : specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "status"), filter) })) }
  var taskCount: Any { "\(specString(specLength(filteredTasks))) tasks" }
  var hasNoResults: Any { specEq(specLength(filteredTasks), 0) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  let tasksSource = DataSource(endpoint: "http://localhost:4000/api/tasks", method: "GET")
  var tasks: Any? { tasksSource.data }
  var tasksLoading: Bool { tasksSource.loading }
  var tasksError: String? { tasksSource.error }
  func setFilter(_ f: Any) {
    filter = f
  }
  func selectTask(_ t: Any) {
    selectedTask = t
    view = "detail"
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func loadSources() async {
    await tasksSource.fetch()
  }
}

struct TaskTableView: View {
  @State private var vm = TaskTableViewModel()
  var selectedTask: Any? = nil
  var view: Any? = nil
  init(selectedTask: Any? = nil, view: Any? = nil) { self._vm = State(initialValue: TaskTableViewModel()); self.selectedTask = selectedTask; self.view = view }
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-2")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("list")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Tasks"))
          .font(.title3.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Text(verbatim: specString(vm.taskCount))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        Spacer(minLength: 0)
        Picker("", selection: Binding(get: { specString(vm.filter) }, set: { vm.filter = $0 })) {
          Text("All").tag("all")
          Text("Todo").tag("todo")
          Text("In Progress").tag("in-progress")
          Text("Done").tag("done")
        }
        .pickerStyle(.segmented)
      }
      .frame(maxWidth: .infinity)
      .padding(ThemeManager.shared.size("spacing-3"))
      .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      .hoverEffect(.highlight)
      VStack(spacing: ThemeManager.shared.size("spacing-2")) {
        if (vm.tasksLoading) as? Bool ?? false {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("48px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("48px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("48px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("48px"))
            .overlay(ProgressView())
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(.tertiarySystemGroupedBackground))
            .frame(height: specPx("48px"))
            .overlay(ProgressView())
        }
      }

      VStack() {
        if (vm.tasksError) as? Bool ?? false {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: specAlertIcon(specString("error")))
              .foregroundStyle(specAlertColor(specString("error")))
            VStack(alignment: .leading, spacing: 4) {
              Text(specString("Failed to load tasks")).font(.subheadline.weight(.semibold))
              Text(specString("The task list could not be retrieved from the server.")).font(.subheadline)
            }
            Spacer(minLength: 0)
          }
          .padding(12)
          .background(specAlertColor(specString("error")).opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
        }
      }

      ForEach(Array(specArr(vm.filteredTasks).enumerated()), id: \.offset) { index, task in
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          Text(verbatim: specString("\(specString(index))"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            Text(verbatim: specString(specGet(task, "title")))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString(specGet(task, "assignee")))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

          Spacer(minLength: 0)
          SpecStatusPill(status: specString(specGet(task, "status")))
          Text(specString("Priority: \(specString(specGet(task, "priority")))")).font(.caption).foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(ThemeManager.shared.size("spacing-3"))
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        .hoverEffect(.highlight)
        .onTapGesture { vm.selectTask(task) }
      }
      VStack() {
        if (vm.hasNoResults) as? Bool ?? false {
          ContentUnavailableView(specString("No Tasks Found"), systemImage: "tray", description: Text(specString("No tasks match the current filter. Try changing your filter criteria.")))
            .frame(height: 200)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
    .onAppear { if !specEq(vm.selectedTask, selectedTask) { vm.selectedTask = selectedTask }; if !specEq(vm.view, view) { vm.view = view } }
    .task(id: specPropsKey([selectedTask, view])) { if !specEq(vm.selectedTask, selectedTask) { vm.selectedTask = selectedTask }; if !specEq(vm.view, view) { vm.view = view } }
  }
}
