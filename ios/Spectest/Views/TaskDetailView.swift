import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TaskDetailViewModel {
  var task: Any? = nil
  var view: Any? = nil
  var confirmingDelete: Any = false
  var hasTask: Any { !specIsNil(task) }
  var taskTitle: Any { (!specIsNil(task) ? specGet(task, "title") : "") }
  var taskStatus: Any { (!specIsNil(task) ? specGet(task, "status") : "") }
  var taskAssignee: Any { (!specIsNil(task) ? specGet(task, "assignee") : "") }
  var taskPriority: Any { (!specIsNil(task) ? specGet(task, "priority") : "") }
  var taskDate: Any { (!specIsNil(task) ? specGet(task, "createdAt") : "") }
  var taskId: Any { (!specIsNil(task) ? specGet(task, "id") : "") }
  var detailHeading: Any { "Task: \(specString(taskTitle))" }
  func goBack() {
    task = Optional<Any>.none as Any
    view = "dashboard"
  }
  func showDeleteConfirm() {
    confirmingDelete = true
  }
  func cancelDelete() {
    confirmingDelete = false
  }
  func confirmDelete() async {
    await __specFetch(specAdd("http://localhost:4500/api/tasks/", taskId), ["method": "DELETE" as Any] as [String: Any])
    confirmingDelete = false
    task = Optional<Any>.none as Any
    view = "dashboard"
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct TaskDetailView: View {
  @State private var vm = TaskDetailViewModel()
  var task: Any? = nil
  var view: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(task: Any? = nil, view: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TaskDetailViewModel(); _m.task = task; _m.view = view; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.task = task; self.view = view; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(task) + "\u{1}" + specChangeKey(view) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Image(systemName: specIconName(specString("eye")))
          .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-md"))))
          .foregroundStyle(ThemeManager.shared.color("interactive"))
        Text(verbatim: specString("Task Detail"))
          .font(.largeTitle)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-lg-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
      }

      if ((!((vm.hasTask) as? Bool ?? false))) as? Bool ?? false {
      VStack(alignment: .leading, spacing: 0) {
        if ((!((vm.hasTask) as? Bool ?? false))) as? Bool ?? false {
          ContentUnavailableView(specString("No Task Selected"), systemImage: "tray", description: Text(specString("Select a task from the Dashboard to view its details here.")))
            .frame(height: 200)
        }
      }

      }
      if (vm.hasTask) as? Bool ?? false {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        if (vm.hasTask) as? Bool ?? false {
          _specArm0
        }
      }

      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.task = task
      vm.view = view
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.task, task) { vm.task = task }; if !specSame(vm.view, view) { vm.view = view } }
    .task(id: specPropsKey([task, view])) { if !specSame(vm.task, task) { vm.task = task }; if !specSame(vm.view, view) { vm.view = view } }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString(vm.detailHeading))
              .font(.title)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
          }
          .padding(.leading, specBorderWidth(ThemeManager.shared.rawToken("borders-accent-interactive-strong")))
          .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: ThemeManager.shared.rawToken("borders-accent-interactive-strong"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          AsyncImage(url: URL(string: specString("https://via.placeholder.com/64"))) { image in
            image.resizable().aspectRatio(contentMode: .fit)
          } placeholder: {
            ProgressView()
          }
          .accessibilityLabel(specString("Task thumbnail"))
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            VStack(alignment: .leading) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Status"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  .textCase(.uppercase)
                SpecStatusPill(status: specString(vm.taskStatus))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .hoverEffect(.highlight)
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Priority"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  .textCase(.uppercase)
                SpecPriorityPill(priority: specString(vm.taskPriority))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .hoverEffect(.highlight)
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Assignee"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  .textCase(.uppercase)
                Text(verbatim: specString(vm.taskAssignee))
                  .font(.body.weight(.semibold))
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .hoverEffect(.highlight)
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
              VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-2"))) {
                Text(verbatim: specString("Created"))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                  .textCase(.uppercase)
                Text(verbatim: specString(vm.taskDate))
                  .font(.body)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-mono-md-fontWeight")))
                  .monospacedDigit()
                  .foregroundStyle(ThemeManager.shared.color("text-primary"))
              }
              .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
              .hoverEffect(.highlight)
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
          }

          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            Button(action: { specClick { Task { @MainActor in await vm.goBack() } } }) {
              Text(specString("Back to Dashboard"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(ThemeManager.shared.color("interactive"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8))
            }
            Button(action: { specClick { Task { @MainActor in await vm.showDeleteConfirm() } } }) {
              Text(specString("Delete Task"))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(ThemeManager.shared.color("destructive"), in: RoundedRectangle(cornerRadius: 8))
            }
          }

          EmptyView().confirmationDialog(specString("Delete Task"), isPresented: Binding(get: { vm.confirmingDelete as? Bool ?? false }, set: { vm.confirmingDelete = $0 }), titleVisibility: .visible) {
            Button(specString("Delete"), role: .destructive) { Task { @MainActor in await vm.confirmDelete() } }
            Button(specString("Cancel"), role: .cancel) { vm.cancelDelete() }
          } message: {
            Text(specString("Are you sure you want to delete this task? This action cannot be undone."))
          }
    })
  }
}
