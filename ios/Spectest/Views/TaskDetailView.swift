import SwiftUI
import SpecRuntime

@Observable
final class TaskDetailViewModel {
  var task: Any? = nil
  var view: Any? = nil
  var confirmingDelete: Any = false
  var hasTask: Any { task != nil }
  var taskTitle: Any { (task != nil ? (task as? [String: Any])?["title"] : "") }
  var taskStatus: Any { (task != nil ? (task as? [String: Any])?["status"] : "") }
  var taskAssignee: Any { (task != nil ? (task as? [String: Any])?["assignee"] : "") }
  var taskPriority: Any { (task != nil ? (task as? [String: Any])?["priority"] : "") }
  var taskDate: Any { (task != nil ? (task as? [String: Any])?["createdAt"] : "") }
  var taskId: Any { (task != nil ? (task as? [String: Any])?["id"] : "") }
  var detailHeading: Any { "Task: \(specString(taskTitle))" }
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
    /* await not yet supported */  _ = Optional<Any>.none
    confirmingDelete = false
    task = nil
    view = "dashboard"
  }
}

struct TaskDetailView: View {
  @State private var vm = TaskDetailViewModel()
  var task: Any? = nil
  var view: Any? = nil
  init(task: Any? = nil, view: Any? = nil) { self._vm = State(initialValue: TaskDetailViewModel()); self.task = task; self.view = view }
  var body: some View {
    VStack(spacing: CGFloat(12)) {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Image(systemName: specIconName(specString("eye")))
          .font(.system(size: specPx("20px")))
          .foregroundStyle(Color(hex: "#1677ff" as? String ?? "#000"))
        Text(specString("Task Detail"))
          .font(.title2.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Spacer(minLength: 0)
      }
      .frame(maxWidth: .infinity)

      VStack() {
        if !(vm.hasTask as? Bool ?? false) {
          ContentUnavailableView(specString("No Task Selected"), systemImage: "tray", description: Text(specString("Select a task from the Dashboard to view its details here.")))
            .frame(height: 200)
        }
      }

      VStack(spacing: CGFloat(12)) {
        if vm.hasTask as? Bool ?? false {
          VStack() {
            Text(specString(vm.detailHeading))
              .font(.title3.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
          }
          .padding(CGFloat(16))
          .background(ThemeManager.shared.color("semantic.surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          AsyncImage(url: URL(string: specString("https://via.placeholder.com/64"))) { image in
            image.resizable().aspectRatio(contentMode: .fit)
          } placeholder: {
            ProgressView()
          }
          .accessibilityLabel(specString("Task thumbnail"))
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(12)) {
            VStack(alignment: .leading) {
              VStack(spacing: CGFloat(8)) {
                Text(specString("Status"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                SpecStatusPill(status: specString(vm.taskStatus))
              }
              .padding(CGFloat(12))
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(spacing: CGFloat(8)) {
                Text(specString("Priority"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                SpecPriorityPill(priority: specString(vm.taskPriority))
              }
              .padding(CGFloat(12))
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(spacing: CGFloat(8)) {
                Text(specString("Assignee"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Text(specString(vm.taskAssignee))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              }
              .padding(CGFloat(12))
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(spacing: CGFloat(8)) {
                Text(specString("Created"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                Text(specString(vm.taskDate))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              }
              .padding(CGFloat(12))
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          }

          HStack(alignment: .center, spacing: CGFloat(12)) {
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
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.task = task; vm.view = view }
  }
}
