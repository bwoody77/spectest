import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TaskTableViewModel {
  var selectedTask: Any? = nil
  var view: Any? = nil
  var filter: Any = "all"
  var taskList: Any { (!specIsNil(tasks) ? tasks : [] as [Any]) }
  var filteredTasks: Any { (specEq(filter, "all") ? taskList : specFilter(taskList, { (t: Any) -> Bool in return specEq(specGet(t, "status"), filter) })) }
  var taskCount: Any { "\(specString(specLength(filteredTasks))) tasks" }
  var hasNoResults: Any { specEq(specLength(filteredTasks), 0) }
  let tasksSource = DataSource(endpoint: "http://localhost:4500/api/tasks", method: "GET")
  var tasks: Any? { tasksSource.data }
  var tasksLoading: Bool { tasksSource.loading }
  var tasksError: String? { tasksSource.error }
  var tasksErrorBody: Any? { tasksSource.errorBody }
  func setFilter(_ f: Any) {
    filter = f
  }
  func selectTask(_ t: Any) {
    selectedTask = t
    view = "detail"
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  func loadSources() async {
    await tasksSource.fetch()
  }
}

struct TaskTableView: View {
  @State private var vm = TaskTableViewModel()
  var selectedTask: Any? = nil
  var view: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(selectedTask: Any? = nil, view: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TaskTableViewModel(); _m.selectedTask = selectedTask; _m.view = view; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.selectedTask = selectedTask; self.view = view; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(selectedTask) + "\u{1}" + specChangeKey(view) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("list")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Tasks"))
          .font(.title)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
      }

      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Text(verbatim: specString(vm.taskCount))
          .font(.footnote)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        Picker("", selection: Binding(get: { specString(vm.filter) }, set: { vm.filter = $0 })) {
          Text("All").tag("all")
          Text("Todo").tag("todo")
          Text("In Progress").tag("in-progress")
          Text("Done").tag("done")
        }
        .pickerStyle(.segmented)
      }
      .padding(specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
      .frame(maxWidth: .infinity, alignment: .center)
      .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .specBorderAll(ThemeManager.shared.rawToken("borders-default"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .specBoxShadow(ThemeManager.shared.rawToken("elevation-flat"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
      .accessibilityElement(children: .contain)
      .accessibilityLabel(specString("Task filters"))
      .hoverEffect(.highlight)
      if (vm.tasksLoading) as? Bool ?? false {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
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

      }
      if (vm.tasksError) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
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

      }
      ForEach(Array(specArr(vm.filteredTasks).enumerated()), id: \.offset) { index, task in
        Button(action: { specClick { vm.selectTask(task) } }) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Text(verbatim: specString("\(specString(index))"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-mono-sm-fontWeight")))
            .monospacedDigit()
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
            Text(verbatim: specString(specGet(task, "title")))
              .font(.body.weight(.medium))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString(specGet(task, "assignee")))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

          SpecStatusPill(status: specString(specGet(task, "status")))
          HStack(spacing: 0) {
            SpecPriorityPill(priority: specString(specGet(task, "priority")))
          }
          .help(specString("Priority: \(specString(specGet(task, "priority")))"))
          .accessibilityHint(specString("Priority: \(specString(specGet(task, "priority")))"))
        }
        .padding(.leading, specBorderWidth(ThemeManager.shared.rawToken("borders-accent-none")))
        .padding(.top, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(.leading, specBorderShorthandWidth(ThemeManager.shared.rawToken("borders-default"), unless: ThemeManager.shared.rawToken("borders-accent-none")))
        .padding(.trailing, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
        .frame(maxWidth: .infinity, alignment: .center)
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderSides(ThemeManager.shared.rawToken("borders-default"), top: nil, right: nil, bottom: nil, left: ThemeManager.shared.rawToken("borders-accent-none"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        .specBoxShadow(ThemeManager.shared.rawToken("elevation-flat"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
        .hoverEffect(.highlight)
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }
      if (vm.hasNoResults) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.hasNoResults) as? Bool ?? false {
          ContentUnavailableView(specString("No Tasks Found"), systemImage: "tray", description: Text(specString("No tasks match the current filter. Try changing your filter criteria.")))
            .frame(height: 200)
        }
      }

      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.selectedTask = selectedTask
      vm.view = view
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .task { await vm.loadSources() }
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.selectedTask, selectedTask) { vm.selectedTask = selectedTask }; if !specSame(vm.view, view) { vm.view = view } }
    .task(id: specPropsKey([selectedTask, view])) { if !specSame(vm.selectedTask, selectedTask) { vm.selectedTask = selectedTask }; if !specSame(vm.view, view) { vm.view = view } }
  }
}
