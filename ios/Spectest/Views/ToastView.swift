import SwiftUI
import SpecRuntime

@Observable
final class ToastViewModel {
  var duration: Any = 5000
  var message: Any? = nil
  var severity: Any = "info"
  var hovered: Any = false
  func startDismiss() {
    // unsupported: delay
  }
  func pauseDismiss() {
    // unsupported: clear-delay
  }
  func resumeDismiss() {
    // unsupported: delay
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ToastView: View {
  @State private var vm = ToastViewModel()
  var duration: Any = 5000
  var message: Any? = nil
  var severity: Any = "info"
  init(duration: Any = 5000, message: Any? = nil, severity: Any = "info") { self._vm = State(initialValue: ToastViewModel()); self.duration = duration; self.message = message; self.severity = severity }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
        Text(verbatim: specString(({ () -> Any in switch specString(vm.severity) {
case specString("success"): return "✓"
case specString("error"): return "✕"
case specString("warning"): return "⚠"
default: return "ℹ"
} })()))
          .font(.body.bold())
          .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("success"): return Color(hex: "#16a34a")
case specString("error"): return Color(hex: "#dc2626")
case specString("warning"): return Color(hex: "#d97706")
default: return Color(hex: "#2563eb")
} })())
        Text(verbatim: specString(vm.message))
          .font(.body.bold())
          .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("success"): return Color(hex: "#166534")
case specString("error"): return Color(hex: "#991b1b")
case specString("warning"): return Color(hex: "#92400e")
default: return Color(hex: "#1e40af")
} })())
        Button(action: { /* event callback */ }) {
        HStack(alignment: .center) {
          Text(verbatim: specString("✕"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        .frame(minWidth: CGFloat(24))
        .frame(minHeight: CGFloat(24))
        }
        .buttonStyle(.plain)
      }
      .padding(ThemeManager.shared.size("spacing-3"))
      .frame(minWidth: CGFloat(300))
      .background(({ () -> Color in switch specString(vm.severity) {
case specString("success"): return Color(hex: "#f0fdf4")
case specString("error"): return Color(hex: "#fef2f2")
case specString("warning"): return Color(hex: "#fffbeb")
default: return Color(hex: "#eff6ff")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.severity, severity) { vm.severity = severity }; if !specEq(vm.duration, duration) { vm.duration = duration } }
    .task(id: specPropsKey([message, severity, duration])) { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.severity, severity) { vm.severity = severity }; if !specEq(vm.duration, duration) { vm.duration = duration } }
  }
}
