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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct StatsBarView: View {
  @State private var vm = StatsBarViewModel()
  var done: Any? = nil
  var inProgress: Any? = nil
  var todo: Any? = nil
  var total: Any? = nil
  init(done: Any? = nil, inProgress: Any? = nil, todo: Any? = nil, total: Any? = nil) { self._vm = State(initialValue: StatsBarViewModel()); self.done = done; self.inProgress = inProgress; self.todo = todo; self.total = total }
  var body: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: CGFloat(16)) {
      VStack(spacing: CGFloat(12)) {
        HStack(alignment: .center, spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("list")))
            .font(.system(size: specPx("24px")))
            .foregroundStyle(Color(hex: "#1677ff" as? String ?? "transparent"))
          Text(verbatim: specString("Total Tasks"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)

        VStack(alignment: .leading, spacing: 4) {
          Text(specString("\(specString(vm.total))")).font(.system(size: 32, weight: .bold, design: .rounded))
          Text(specString("tasks")).font(.subheadline).foregroundStyle(.secondary)
        }
      }
      .padding(CGFloat(16))
      .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.info-bg"), Color(hex: "#bae0ff")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      .hoverEffect(.highlight)
      VStack(spacing: CGFloat(12)) {
        HStack(alignment: .center, spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx("24px")))
            .foregroundStyle(Color(hex: "#52c41a" as? String ?? "transparent"))
          Text(verbatim: specString("Completed"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
      .padding(CGFloat(16))
      .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.success-light"), Color(hex: "#b7eb8f")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      .hoverEffect(.highlight)
      VStack(spacing: CGFloat(12)) {
        HStack(alignment: .center, spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("loader")))
            .font(.system(size: specPx("24px")))
            .foregroundStyle(Color(hex: "#faad14" as? String ?? "transparent"))
          Text(verbatim: specString("In Progress"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
      .padding(CGFloat(16))
      .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.warning-light"), Color(hex: "#ffe58f")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      .hoverEffect(.highlight)
      VStack(spacing: CGFloat(12)) {
        HStack(alignment: .center, spacing: CGFloat(12)) {
          Image(systemName: specIconName(specString("circle")))
            .font(.system(size: specPx("24px")))
            .foregroundStyle(Color(hex: "#5c7aa3" as? String ?? "transparent"))
          Text(verbatim: specString("Todo"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
      .padding(CGFloat(16))
      .background(LinearGradient(colors: [ThemeManager.shared.color("semantic.surface"), ThemeManager.shared.color("semantic.border")], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      .hoverEffect(.highlight)
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.total, total) { vm.total = total }; if !specEq(vm.done, done) { vm.done = done }; if !specEq(vm.inProgress, inProgress) { vm.inProgress = inProgress }; if !specEq(vm.todo, todo) { vm.todo = todo } }
    .task(id: specPropsKey([total, done, inProgress, todo])) { if !specEq(vm.total, total) { vm.total = total }; if !specEq(vm.done, done) { vm.done = done }; if !specEq(vm.inProgress, inProgress) { vm.inProgress = inProgress }; if !specEq(vm.todo, todo) { vm.todo = todo } }
  }
}
