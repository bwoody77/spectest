import SwiftUI
import SpecRuntime

@Observable
final class TaskDetailViewModel {
  var task: Any? = nil
  var view: Any? = nil
  var confirmingDelete: Any = false
  var hasTask: Any { task != nil }
  var taskTitle: Any { (task != nil ? specGet(task, "title") : "") }
  var taskStatus: Any { (task != nil ? specGet(task, "status") : "") }
  var taskAssignee: Any { (task != nil ? specGet(task, "assignee") : "") }
  var taskPriority: Any { (task != nil ? specGet(task, "priority") : "") }
  var taskDate: Any { (task != nil ? specGet(task, "createdAt") : "") }
  var taskId: Any { (task != nil ? specGet(task, "id") : "") }
  var detailHeading: Any { "Task: \(specString(taskTitle))" }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func goBack() {
    task = nil
    view = "dashboard"
  }
  func showDeleteConfirm() {
    confirmingDelete = true
  }
  func cancelDelete() {
    confirmingDelete = false
  }
  func confirmDelete() async {
    await fetch(specAdd("http://localhost:4000/api/tasks/", taskId), ["method": "DELETE" as Any] as [String: Any])
    confirmingDelete = false
    task = nil
    view = "dashboard"
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct TaskDetailView: View {
  @State private var vm = TaskDetailViewModel()
  var task: Any? = nil
  var view: Any? = nil
  init(task: Any? = nil, view: Any? = nil) { self._vm = State(initialValue: TaskDetailViewModel()); self.task = task; self.view = view }
  var body: some View {
    VStack(spacing: ThemeManager.shared.size("spacing-3")) {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Image(systemName: specIconName(specString("eye")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Task Detail"))
          .font(.title2.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      VStack() {
        if ((!((vm.hasTask) as? Bool ?? false))) as? Bool ?? false {
          ContentUnavailableView(specString("No Task Selected"), systemImage: "tray", description: Text(specString("Select a task from the Dashboard to view its details here.")))
            .frame(height: 200)
        }
      }

      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        if (vm.hasTask) as? Bool ?? false {
          VStack() {
            Text(verbatim: specString(vm.detailHeading))
              .font(.title3.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
          }
          .padding(ThemeManager.shared.size("spacing-4"))
          .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
          AsyncImage(url: URL(string: specString("https://via.placeholder.com/64"))) { image in
            image.resizable().aspectRatio(contentMode: .fit)
          } placeholder: {
            ProgressView()
          }
          .accessibilityLabel(specString("Task thumbnail"))
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: ThemeManager.shared.size("spacing-3")) {
            VStack(alignment: .leading) {
              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("Status"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                SpecStatusPill(status: specString(vm.taskStatus))
              }
              .padding(ThemeManager.shared.size("spacing-3"))
              .hoverEffect(.highlight)
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("Priority"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                SpecPriorityPill(priority: specString(vm.taskPriority))
              }
              .padding(ThemeManager.shared.size("spacing-3"))
              .hoverEffect(.highlight)
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("Assignee"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString(vm.taskAssignee))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(ThemeManager.shared.size("spacing-3"))
              .hoverEffect(.highlight)
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(spacing: ThemeManager.shared.size("spacing-2")) {
                Text(verbatim: specString("Created"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                Text(verbatim: specString(vm.taskDate))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(ThemeManager.shared.size("spacing-3"))
              .hoverEffect(.highlight)
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          }

          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
            Button(action: { Task { @MainActor in await vm.goBack() } }) {
              Text(specString("Back to Dashboard"))
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
            }
            Button(action: { Task { @MainActor in await vm.showDeleteConfirm() } }) {
              Text(specString("Delete Task"))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(specString("destructive") == "primary" ? .white : .blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(specString("destructive") == "primary" ? AnyShapeStyle(.blue) : AnyShapeStyle(Color(.tertiarySystemFill)), in: RoundedRectangle(cornerRadius: 8))
            }
          }

          EmptyView().confirmationDialog(specString("Delete Task"), isPresented: Binding(get: { vm.confirmingDelete as? Bool ?? false }, set: { vm.confirmingDelete = $0 })) {
            Button("Confirm") { Task { @MainActor in await vm.confirmDelete() } }
            Button("Cancel", role: .cancel) {}
          } message: {
            Text(specString("Are you sure you want to delete this task? This action cannot be undone."))
          }
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.task, task) { vm.task = task }; if !specEq(vm.view, view) { vm.view = view } }
    .task(id: specPropsKey([task, view])) { if !specEq(vm.task, task) { vm.task = task }; if !specEq(vm.view, view) { vm.view = view } }
  }
}
