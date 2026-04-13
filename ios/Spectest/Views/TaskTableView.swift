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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
    VStack(spacing: CGFloat(8)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("list")))
          .font(.system(size: specPx("20px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
        Text(verbatim: specString("Tasks"))
          .font(.title3.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      HStack(alignment: .center, spacing: CGFloat(12)) {
        Text(verbatim: specString(vm.taskCount))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
      .padding(CGFloat(12))
      .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      VStack(spacing: CGFloat(8)) {
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
        HStack(alignment: .center, spacing: CGFloat(12)) {
          Text(verbatim: specString("\(specString(index))"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          VStack(spacing: CGFloat(4)) {
            Text(verbatim: specString(specGet(task, "title")))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(verbatim: specString(specGet(task, "assignee")))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }

          Spacer(minLength: 0)
          SpecStatusPill(status: specString(specGet(task, "status")))
          Text(specString("Priority: \(specString(specGet(task, "priority")))")).font(.caption).foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(CGFloat(12))
        .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.selectTask(task) }
      }
      VStack() {
        if (vm.hasNoResults) as? Bool ?? false {
          ContentUnavailableView(specString("No Tasks Found"), systemImage: "tray", description: Text(specString("No tasks match the current filter. Try changing your filter criteria.")))
            .frame(height: 200)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .refreshable { await vm.loadSources() }
    .onAppear { if !specEq(vm.selectedTask, selectedTask) { vm.selectedTask = selectedTask }; if !specEq(vm.view, view) { vm.view = view } }
    .task(id: specPropsKey([selectedTask, view])) { if !specEq(vm.selectedTask, selectedTask) { vm.selectedTask = selectedTask }; if !specEq(vm.view, view) { vm.view = view } }
  }
}
