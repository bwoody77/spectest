import SwiftUI
import SpecRuntime

@Observable
final class AlertViewModel {
  var dismissible: Any = false
  var message: Any? = nil
  var severity: Any = "info"
  var title: Any = ""
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
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
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
        Image(systemName: specIconName(specString(({ () -> Any in switch specString(vm.severity) {
case specString("info"): return "info"
case specString("success"): return "circle-check"
case specString("warning"): return "alert-triangle"
case specString("error"): return "circle-x"
default: return "info"
} })())))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xs"))))
          .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-text")
case specString("success"): return ThemeManager.shared.color("alert-success-text")
case specString("warning"): return ThemeManager.shared.color("alert-warning-text")
case specString("error"): return ThemeManager.shared.color("alert-error-text")
default: return ThemeManager.shared.color("alert-info-text")
} })())
        VStack(spacing: CGFloat(2)) {
          Text(verbatim: specString(vm.title))
            .font(.body.bold())
            .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-text")
case specString("success"): return ThemeManager.shared.color("alert-success-text")
case specString("warning"): return ThemeManager.shared.color("alert-warning-text")
case specString("error"): return ThemeManager.shared.color("alert-error-text")
default: return ThemeManager.shared.color("alert-info-text")
} })())
          Text(verbatim: specString(vm.message))
            .font(.body.bold())
            .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-text")
case specString("success"): return ThemeManager.shared.color("alert-success-text")
case specString("warning"): return ThemeManager.shared.color("alert-warning-text")
case specString("error"): return ThemeManager.shared.color("alert-error-text")
default: return ThemeManager.shared.color("alert-info-text")
} })())
        }
        .frame(maxWidth: .infinity)
        Button(action: { /* event callback */ }) {
        HStack(alignment: .center) {
          if specEq(vm.dismissible, true) {
            Text(verbatim: specString("u00D7"))
              .font(.body.bold())
              .foregroundStyle(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-text")
case specString("success"): return ThemeManager.shared.color("alert-success-text")
case specString("warning"): return ThemeManager.shared.color("alert-warning-text")
case specString("error"): return ThemeManager.shared.color("alert-error-text")
default: return ThemeManager.shared.color("alert-info-text")
} })())
          }
        }
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
        .frame(width: CGFloat(24))
        .specFrameHeight(CGFloat(24))
        .frame(minWidth: CGFloat(24))
        .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
        .hoverEffect(.highlight)
        }
        .buttonStyle(.plain)
      }
      .padding(ThemeManager.shared.size("spacing-3"))
      .background(({ () -> Color in switch specString(vm.severity) {
case specString("info"): return ThemeManager.shared.color("alert-info-bg")
case specString("success"): return ThemeManager.shared.color("alert-success-bg")
case specString("warning"): return ThemeManager.shared.color("alert-warning-bg")
case specString("error"): return ThemeManager.shared.color("alert-error-bg")
default: return ThemeManager.shared.color("alert-info-bg")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("alert-radius")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.severity, severity) { vm.severity = severity }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.dismissible, dismissible) { vm.dismissible = dismissible } }
    .task(id: specPropsKey([message, severity, title, dismissible])) { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.severity, severity) { vm.severity = severity }; if !specEq(vm.title, title) { vm.title = title }; if !specEq(vm.dismissible, dismissible) { vm.dismissible = dismissible } }
  }
}
