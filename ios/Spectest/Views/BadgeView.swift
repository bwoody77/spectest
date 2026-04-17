import SwiftUI
import SpecRuntime

@Observable
final class BadgeViewModel {
  var text: Any? = nil
  var variant: Any = "neutral"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct BadgeView: View {
  @State private var vm = BadgeViewModel()
  var text: Any? = nil
  var variant: Any = "neutral"
  init(text: Any? = nil, variant: Any = "neutral") { self._vm = State(initialValue: BadgeViewModel()); self.text = text; self.variant = variant }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(4)) {
        Text(verbatim: specString(vm.text))
          .font(.body.bold())
          .foregroundStyle(({ () -> Color in switch specString(vm.variant) {
case specString("info"): return ThemeManager.shared.color("badge-info-color")
case specString("success"): return ThemeManager.shared.color("badge-success-color")
case specString("warning"): return ThemeManager.shared.color("badge-warning-color")
case specString("error"): return ThemeManager.shared.color("badge-error-color")
case specString("neutral"): return ThemeManager.shared.color("badge-neutral-color")
default: return ThemeManager.shared.color("badge-neutral-color")
} })())
      }
      .padding(.leading, CGFloat(10))
      .padding(.trailing, CGFloat(10))
      .padding(.top, CGFloat(2))
      .padding(.bottom, CGFloat(2))
      .background(({ () -> Color in switch specString(vm.variant) {
case specString("info"): return ThemeManager.shared.color("badge-info-bg")
case specString("success"): return ThemeManager.shared.color("badge-success-bg")
case specString("warning"): return ThemeManager.shared.color("badge-warning-bg")
case specString("error"): return ThemeManager.shared.color("badge-error-bg")
case specString("neutral"): return ThemeManager.shared.color("badge-neutral-bg")
default: return ThemeManager.shared.color("badge-neutral-bg")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("badge-radius")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.text, text) { vm.text = text }; if !specEq(vm.variant, variant) { vm.variant = variant } }
    .task(id: specPropsKey([text, variant])) { if !specEq(vm.text, text) { vm.text = text }; if !specEq(vm.variant, variant) { vm.variant = variant } }
  }
}
