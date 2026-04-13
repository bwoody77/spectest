import SwiftUI
import SpecRuntime

@Observable
final class SeverityBadgeViewModel {
  var severity: Any? = nil
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct SeverityBadgeView: View {
  @State private var vm = SeverityBadgeViewModel()
  var severity: Any? = nil
  init(severity: Any? = nil) { self._vm = State(initialValue: SeverityBadgeViewModel()); self.severity = severity }
  var body: some View {
    VStack() {
      Text(specString(({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "Info"
case specString("success"): return "Success"
case specString("warning"): return "Warning"
case specString("error"): return "Error"
default: return "Unknown"
} })()))
        .font(.caption.weight(.medium))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(specBadgeForeground(specString(({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "info"
case specString("success"): return "success"
case specString("warning"): return "warning"
case specString("error"): return "error"
default: return "neutral"
} })())))
        .background(specBadgeBackground(specString(({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "info"
case specString("success"): return "success"
case specString("warning"): return "warning"
case specString("error"): return "error"
default: return "neutral"
} })())), in: Capsule())
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.severity, severity) { vm.severity = severity } }
    .task(id: specPropsKey([severity])) { if !specEq(vm.severity, severity) { vm.severity = severity } }
  }
}
