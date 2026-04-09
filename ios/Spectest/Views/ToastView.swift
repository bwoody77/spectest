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
}

struct ToastView: View {
  @State private var vm = ToastViewModel()
  var duration: Any = 5000
  var message: Any? = nil
  var severity: Any = "info"
  init(duration: Any = 5000, message: Any? = nil, severity: Any = "info") { self._vm = State(initialValue: ToastViewModel()); self.duration = duration; self.message = message; self.severity = severity }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(12)) {
        Text(specString(({ () -> Any in switch specString(vm.severity) {
case specString("success"): return "✓"
case specString("error"): return "✕"
case specString("warning"): return "⚠"
default: return "ℹ"
} })()))
          .font(.body.bold())
          .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("success"): return "#16a34a"
case specString("error"): return "#dc2626"
case specString("warning"): return "#d97706"
default: return "#2563eb"
} })() as? String ?? "#000"))
        Text(specString(vm.message))
          .font(.body.bold())
          .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("success"): return "#166534"
case specString("error"): return "#991b1b"
case specString("warning"): return "#92400e"
default: return "#1e40af"
} })() as? String ?? "#000"))
        HStack(alignment: .center, ) {
          Text(specString("✕"))
            .font(.body.bold())
            .foregroundStyle(.tertiary)
        }
        .padding(CGFloat(8))
        .frame(minWidth: CGFloat(24))
        .frame(minHeight: CGFloat(24))
        .onTapGesture { /* event callback */ }
      }
      .padding(CGFloat(12))
      .frame(minWidth: CGFloat(300))
      .background(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("success"): return "#f0fdf4"
case specString("error"): return "#fef2f2"
case specString("warning"): return "#fffbeb"
default: return "#eff6ff"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.message = message; vm.severity = severity; vm.duration = duration }
  }
}
