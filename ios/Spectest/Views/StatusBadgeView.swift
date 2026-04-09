import SwiftUI
import SpecRuntime

@Observable
final class StatusBadgeViewModel {
  var status: Any? = nil
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct StatusBadgeView: View {
  @State private var vm = StatusBadgeViewModel()
  var status: Any? = nil
  init(status: Any? = nil) { self._vm = State(initialValue: StatusBadgeViewModel()); self.status = status }
  var body: some View {
    VStack() {
      Text(specString(({ () -> Any in switch specString(vm.status) {
case specString("todo"): return "Todo"
case specString("in-progress"): return "In Progress"
case specString("done"): return "Done"
default: return "Unknown"
} })()))
        .font(.caption.weight(.medium))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(specBadgeForeground(specString(({ () -> Any in switch specString(vm.status) {
case specString("todo"): return "neutral"
case specString("in-progress"): return "warning"
case specString("done"): return "success"
default: return "neutral"
} })())))
        .background(specBadgeBackground(specString(({ () -> Any in switch specString(vm.status) {
case specString("todo"): return "neutral"
case specString("in-progress"): return "warning"
case specString("done"): return "success"
default: return "neutral"
} })())), in: Capsule())
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.status = status }
  }
}
