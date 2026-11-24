import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class PriorityBadgeViewModel {
  var priority: Any? = nil
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct PriorityBadgeView: View {
  @State private var vm = PriorityBadgeViewModel()
  var priority: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(priority: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = PriorityBadgeViewModel(); _m.priority = priority; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.priority = priority; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(priority) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
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
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.priority = priority
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.priority, priority) { vm.priority = priority } }
    .task(id: specPropsKey([priority])) { if !specSame(vm.priority, priority) { vm.priority = priority } }
  }
}
