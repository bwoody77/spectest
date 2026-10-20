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
