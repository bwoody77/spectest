import SwiftUI
import SpecRuntime

@Observable
final class ActivityIconViewModel {
  var activityType: Any? = nil
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
        .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.activityType) {
case specString("task_created"): return "#3b82f6"
case specString("task_completed"): return "#10b981"
case specString("task_assigned"): return "#8b5cf6"
case specString("comment"): return "#f59e0b"
case specString("deploy"): return "#06b6d4"
default: return "#64748b"
} })() as? String ?? "#000"))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.activityType = activityType }
  }
}
