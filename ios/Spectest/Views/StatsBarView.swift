import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class StatsBarViewModel {
  var done: Any? = nil
  var inProgress: Any? = nil
  var todo: Any? = nil
  var total: Any? = nil
  var donePercent: Any { ((specGt(total, 0)) as? Bool ?? false ? (specDouble((specDouble(done) * specDouble(100))) / specDouble(total)) : 0) }
  var inProgressPercent: Any { ((specGt(total, 0)) as? Bool ?? false ? (specDouble((specDouble(inProgress) * specDouble(100))) / specDouble(total)) : 0) }
  var todoPercent: Any { ((specGt(total, 0)) as? Bool ?? false ? (specDouble((specDouble(todo) * specDouble(100))) / specDouble(total)) : 0) }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct StatsBarView: View {
  @State private var vm = StatsBarViewModel()
  var done: Any? = nil
  var inProgress: Any? = nil
  var todo: Any? = nil
  var total: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(done: Any? = nil, inProgress: Any? = nil, todo: Any? = nil, total: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = StatsBarViewModel(); _m.done = done; _m.inProgress = inProgress; _m.todo = todo; _m.total = total; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.done = done; self.inProgress = inProgress; self.todo = todo; self.total = total; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(done) + "\u{1}" + specChangeKey(inProgress) + "\u{1}" + specChangeKey(todo) + "\u{1}" + specChangeKey(total) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("list")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("interactive"))
          Text(verbatim: specString("Total Tasks"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            .textCase(.uppercase)
        }

        VStack(alignment: .center, spacing: 2) {
          Text(specString("tasks")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
          Text(specString("\(specString(vm.total))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
          if specString("") != "" {
            let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
            HStack(spacing: 4) {
              Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
              if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
            }
          }
          if specString("") != "" {
            Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
          }
        }
        .frame(maxWidth: .infinity)
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("gradient-stat-primary-subtle"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .hoverEffect(.highlight)
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("check")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("success"))
          Text(verbatim: specString("Completed"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            .textCase(.uppercase)
        }

        VStack(alignment: .center, spacing: 2) {
          Text(specString("done")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
          Text(specString("\(specString(vm.done))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
          if specString("") != "" {
            let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
            HStack(spacing: 4) {
              Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
              if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
            }
          }
          if specString("") != "" {
            Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
          }
        }
        .frame(maxWidth: .infinity)
        ProgressView(value: (vm.donePercent as? Double ?? 0) / 100.0)
          .tint(.accentColor)
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("gradient-stat-success-subtle"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .hoverEffect(.highlight)
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("loader")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("warning"))
          Text(verbatim: specString("In Progress"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            .textCase(.uppercase)
        }

        VStack(alignment: .center, spacing: 2) {
          Text(specString("active")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
          Text(specString("\(specString(vm.inProgress))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
          if specString("") != "" {
            let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
            HStack(spacing: 4) {
              Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
              if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
            }
          }
          if specString("") != "" {
            Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
          }
        }
        .frame(maxWidth: .infinity)
        ProgressView(value: (vm.inProgressPercent as? Double ?? 0) / 100.0)
          .tint(.accentColor)
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("gradient-stat-warning-subtle"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .hoverEffect(.highlight)
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
          Image(systemName: specIconName(specString("circle")))
            .font(.system(size: specPx(ThemeManager.shared.rawToken("icon-lg"))))
            .foregroundStyle(ThemeManager.shared.color("text-muted"))
          Text(verbatim: specString("Todo"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            .textCase(.uppercase)
        }

        VStack(alignment: .center, spacing: 2) {
          Text(specString("remaining")).font(.body).textCase(.uppercase).tracking(0.8).foregroundStyle(ThemeManager.shared.color("text-secondary")).lineLimit(1).minimumScaleFactor(0.7)
          Text(specString("\(specString(vm.todo))")).font(.title3.weight(.bold)).foregroundStyle(ThemeManager.shared.color("text-primary")).lineLimit(1).minimumScaleFactor(0.6)
          if specString("") != "" {
            let _tc: Color = specString("") == "up" ? Color(hex: "#22c55e") : (specString("") == "down" ? Color(hex: "#ef4444") : ThemeManager.shared.color("text-tertiary"))
            HStack(spacing: 4) {
              Text(specString("") == "up" ? "↑" : (specString("") == "down" ? "↓" : "→")).font(.footnote).foregroundStyle(_tc)
              if specString("") != "" { Text(specString("")).font(.footnote).foregroundStyle(_tc) }
            }
          }
          if specString("") != "" {
            Text(specString("")).font(.footnote).foregroundStyle(ThemeManager.shared.color("text-tertiary")).multilineTextAlignment(.center)
          }
        }
        .frame(maxWidth: .infinity)
        ProgressView(value: (vm.todoPercent as? Double ?? 0) / 100.0)
          .tint(.accentColor)
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-4")))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("gradient-stat-neutral-subtle"), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
      .hoverEffect(.highlight)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.done = done
      vm.inProgress = inProgress
      vm.todo = todo
      vm.total = total
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.total, total) { vm.total = total }; if !specSame(vm.done, done) { vm.done = done }; if !specSame(vm.inProgress, inProgress) { vm.inProgress = inProgress }; if !specSame(vm.todo, todo) { vm.todo = todo } }
    .task(id: specPropsKey([total, done, inProgress, todo])) { if !specSame(vm.total, total) { vm.total = total }; if !specSame(vm.done, done) { vm.done = done }; if !specSame(vm.inProgress, inProgress) { vm.inProgress = inProgress }; if !specSame(vm.todo, todo) { vm.todo = todo } }
  }
}
