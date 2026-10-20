import SwiftUI
import SpecRuntime

@Observable
final class ActivityIconViewModel {
  var activityType: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ActivityIconView: View {
  @State private var vm = ActivityIconViewModel()
  var activityType: Any? = nil
  init(activityType: Any? = nil) { self._vm = State(initialValue: ActivityIconViewModel()); self.activityType = activityType }
  var body: some View {
    VStack() {
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
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.activityType, activityType) { vm.activityType = activityType } }
    .task(id: specPropsKey([activityType])) { if !specEq(vm.activityType, activityType) { vm.activityType = activityType } }
  }
}
