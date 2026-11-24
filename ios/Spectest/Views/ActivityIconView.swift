import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class ActivityIconViewModel {
  var activityType: Any? = nil
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct ActivityIconView: View {
  @State private var vm = ActivityIconViewModel()
  var activityType: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(activityType: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = ActivityIconViewModel(); _m.activityType = activityType; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.activityType = activityType; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(activityType) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      Group {
        if !specString(({ () -> Any in switch specString(vm.activityType) {
case specString("task_created"): return "plus"
case specString("task_completed"): return "check"
case specString("task_assigned"): return "user"
case specString("comment"): return "message-circle"
case specString("deploy"): return "upload"
default: return "circle"
} })()).trimmingCharacters(in: .whitespaces).isEmpty {
          Image(systemName: specIconName(specString(({ () -> Any in switch specString(vm.activityType) {
case specString("task_created"): return "plus"
case specString("task_completed"): return "check"
case specString("task_assigned"): return "user"
case specString("comment"): return "message-circle"
case specString("deploy"): return "upload"
default: return "circle"
} })())))
            .font(.system(size: specPx("18px")))
            .foregroundStyle(({ () -> Color in switch specString(vm.activityType) {
case specString("task_created"): return Color(hex: "#3b82f6")
case specString("task_completed"): return Color(hex: "#10b981")
case specString("task_assigned"): return Color(hex: "#8b5cf6")
case specString("comment"): return Color(hex: "#f59e0b")
case specString("deploy"): return Color(hex: "#06b6d4")
default: return Color(hex: "#64748b")
} })())
        }
      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.activityType = activityType
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.activityType, activityType) { vm.activityType = activityType } }
    .task(id: specPropsKey([activityType])) { if !specSame(vm.activityType, activityType) { vm.activityType = activityType } }
  }
}
