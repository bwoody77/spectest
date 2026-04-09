import SwiftUI
import SpecRuntime

@Observable
final class AlertViewModel {
  var dismissible: Any = false
  var message: Any? = nil
  var severity: Any = "info"
  var title: Any = ""
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
} })() as? String ?? "#000"))
        VStack(spacing: CGFloat(2)) {
          Text(specString(vm.title))
            .font(.body.bold())
            .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#1e40af"
case specString("success"): return "#166534"
case specString("warning"): return "#92400e"
case specString("error"): return "#991b1b"
default: return "#1e40af"
} })() as? String ?? "#000"))
          Text(specString(vm.message))
            .font(.body.bold())
            .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#1e40af"
case specString("success"): return "#166534"
case specString("warning"): return "#92400e"
case specString("error"): return "#991b1b"
default: return "#1e40af"
} })() as? String ?? "#000"))
        }
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
        HStack(alignment: .center, ) {
          if (specString(vm.dismissible) == specString(true)) {
            Text(specString("u00D7"))
              .font(.body.bold())
              .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#1e40af"
case specString("success"): return "#166534"
case specString("warning"): return "#92400e"
case specString("error"): return "#991b1b"
default: return "#1e40af"
} })() as? String ?? "#000"))
          }
        }
        .clipShape(RoundedRectangle(cornerRadius: CGFloat(6)))
        .frame(width: CGFloat(24))
        .frame(height: CGFloat(24))
        .frame(minWidth: CGFloat(24))
        .clipShape(RoundedRectangle(cornerRadius: CGFloat(6)))
        .onTapGesture { /* event callback */ }
      }
      .padding(CGFloat(12))
      .background(Color(hex: ({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "#eff6ff"
case specString("success"): return "#f0fdf4"
case specString("warning"): return "#fffbeb"
case specString("error"): return "#fef2f2"
default: return "#eff6ff"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(8)))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.message = message; vm.severity = severity; vm.title = title; vm.dismissible = dismissible }
  }
}
