import SwiftUI
import SpecRuntime

@Observable
final class PriorityBadgeViewModel {
  var priority: Any? = nil
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct PriorityBadgeView: View {
  @State private var vm = PriorityBadgeViewModel()
  var priority: Any? = nil
  init(priority: Any? = nil) { self._vm = State(initialValue: PriorityBadgeViewModel()); self.priority = priority }
  var body: some View {
    VStack() {
      Text(specString(({ () -> Any in switch specString(vm.priority) {
case specString("low"): return "Low"
case specString("medium"): return "Medium"
case specString("high"): return "High"
case specString("critical"): return "Critical"
default: return "—"
} })()))
        .font(.caption.weight(.medium))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(specBadgeForeground(specString(({ () -> Any in switch specString(vm.priority) {
case specString("low"): return "neutral"
case specString("medium"): return "warning"
case specString("high"): return "error"
case specString("critical"): return "error"
default: return "neutral"
} })())))
        .background(specBadgeBackground(specString(({ () -> Any in switch specString(vm.priority) {
case specString("low"): return "neutral"
case specString("medium"): return "warning"
case specString("high"): return "error"
case specString("critical"): return "error"
default: return "neutral"
} })())), in: Capsule())
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.priority, priority) { vm.priority = priority } }
    .task(id: specPropsKey([priority])) { if !specEq(vm.priority, priority) { vm.priority = priority } }
  }
}
