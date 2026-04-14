import SwiftUI
import SpecRuntime

@Observable
final class AlertViewModel {
  var dismissible: Any = false
  var message: Any? = nil
  var severity: Any = "info"
  var title: Any = ""
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct AlertView: View {
  @State private var vm = AlertViewModel()
  var dismissible: Any = false
  var message: Any? = nil
  var severity: Any = "info"
  var title: Any = ""
  init(dismissible: Any = false, message: Any? = nil, severity: Any = "info", title: Any = "") { self._vm = State(initialValue: AlertViewModel()); self.dismissible = dismissible; self.message = message; self.severity = severity; self.title = title }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(8)) {
        Image(systemName: specIconName(specString(({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "info"
case specString("success"): return "circle-check"
case specString("warning"): return "alert-triangle"
case specString("error"): return "circle-x"
default: return "info"
} })())))
          .font(.system(size: specPx("16px")))
          .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#1e40af"
case specString("success"): return "#166534"
case specString("warning"): return "#92400e"
case specString("error"): return "#991b1b"
default: return "#1e40af"
} })() as? String ?? "transparent"))
        VStack(spacing: CGFloat(2)) {
          Text(verbatim: specString(vm.title))
            .font(.body.bold())
            .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#1e40af"
case specString("success"): return "#166534"
case specString("warning"): return "#92400e"
case specString("error"): return "#991b1b"
default: return "#1e40af"
} })() as? String ?? "transparent"))
          Text(verbatim: specString(vm.message))
            .font(.body.bold())
            .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#1e40af"
case specString("success"): return "#166534"
case specString("warning"): return "#92400e"
case specString("error"): return "#991b1b"
default: return "#1e40af"
} })() as? String ?? "transparent"))
        }
        .frame(maxWidth: .infinity)
        Button(action: { /* event callback */ }) {
        HStack(alignment: .center, ) {
          if specEq(vm.dismissible, true) {
            Text(verbatim: specString("u00D7"))
              .font(.body.bold())
              .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#1e40af"
case specString("success"): return "#166534"
case specString("warning"): return "#92400e"
case specString("error"): return "#991b1b"
default: return "#1e40af"
} })() as? String ?? "transparent"))
          }
        }
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
        .frame(width: CGFloat(24))
        .specFrameHeight(CGFloat(24))
        .frame(minWidth: CGFloat(24))
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
        .hoverEffect(.highlight)
        }
        .buttonStyle(.plain)
      }
      .padding(CGFloat(12))
      .background(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#eff6ff"
case specString("success"): return "#f0fdf4"
case specString("warning"): return "#fffbeb"
case specString("error"): return "#fef2f2"
default: return "#eff6ff"
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.severity, severity) { vm.severity = severity }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.dismissible, dismissible) { vm.dismissible = dismissible } }
    .task(id: specPropsKey([message, severity, title, dismissible])) { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.severity, severity) { vm.severity = severity }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.dismissible, dismissible) { vm.dismissible = dismissible } }
  }
}
