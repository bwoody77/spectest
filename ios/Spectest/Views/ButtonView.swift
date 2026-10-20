import SwiftUI
import SpecRuntime

@Observable
final class ButtonViewModel {
  var disabled: Any = false
  var label: Any? = nil
  var loading: Any = false
  var pressed: Any = false
  var size: Any = "md"
  var variant: Any = "primary"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ButtonView: View {
  @State private var vm = ButtonViewModel()
  var disabled: Any = false
  var label: Any? = nil
  var loading: Any = false
  var pressed: Any = false
  var size: Any = "md"
  var variant: Any = "primary"
  init(disabled: Any = false, label: Any? = nil, loading: Any = false, pressed: Any = false, size: Any = "md", variant: Any = "primary") { self._vm = State(initialValue: ButtonViewModel()); self.disabled = disabled; self.label = label; self.loading = loading; self.pressed = pressed; self.size = size; self.variant = variant }
  var body: some View {
    VStack() {
      Button(action: {  }) {
        Text(verbatim: specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(({ () -> Color in switch specString(vm.variant) {
case specString("primary"): return ThemeManager.shared.color("btn-primary-color")
case specString("secondary"): return ThemeManager.shared.color("btn-secondary-color")
case specString("ghost"): return ThemeManager.shared.color("btn-ghost-color")
case specString("destructive"): return ThemeManager.shared.color("btn-destructive-color")
default: return ThemeManager.shared.color("btn-primary-color")
} })())
      }
      .padding(.leading, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "8px"
case specString("lg"): return "24px"
default: return ThemeManager.shared.resolve("btn-paddingH")
} })()))
      .padding(.trailing, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "8px"
case specString("lg"): return "24px"
default: return ThemeManager.shared.resolve("btn-paddingH")
} })()))
      .padding(.top, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "4px"
case specString("lg"): return "12px"
default: return ThemeManager.shared.resolve("btn-paddingV")
} })()))
      .padding(.bottom, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "4px"
case specString("lg"): return "12px"
default: return ThemeManager.shared.resolve("btn-paddingV")
} })()))
      .opacity(specPx(({ () -> Any in switch specString(vm.loading) {
case specString(true): return 0.7
default: return ({ () -> Any in switch specString(vm.disabled) {
case specString(true): return 0.5
default: return 1
} })()
} })()))
      .background(({ () -> Color in switch specString(vm.pressed) {
case specString(true): return ({ () -> Color in switch specString(vm.variant) {
case specString("primary"): return ThemeManager.shared.color("btn-primary-hover")
case specString("secondary"): return ThemeManager.shared.color("btn-secondary-hover")
case specString("ghost"): return ThemeManager.shared.color("btn-ghost-hover")
case specString("destructive"): return ThemeManager.shared.color("btn-destructive-hover")
default: return ThemeManager.shared.color("btn-primary-hover")
} })()
default: return ({ () -> Color in switch specString(vm.variant) {
case specString("primary"): return ThemeManager.shared.color("btn-primary-bg")
case specString("secondary"): return ThemeManager.shared.color("btn-secondary-bg")
case specString("ghost"): return Color.clear
case specString("destructive"): return ThemeManager.shared.color("btn-destructive-bg")
default: return ThemeManager.shared.color("btn-primary-bg")
} })()
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("btn-radius")))
      .hoverEffect(.highlight)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.variant, variant) { vm.variant = variant }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.loading, loading) { vm.loading = loading }; if !specEq(vm.pressed, pressed) { vm.pressed = pressed }; if !specEq(vm.size, size) { vm.size = size } }
    .task(id: specPropsKey([label, variant, disabled, loading, pressed, size])) { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.variant, variant) { vm.variant = variant }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.loading, loading) { vm.loading = loading }; if !specEq(vm.pressed, pressed) { vm.pressed = pressed }; if !specEq(vm.size, size) { vm.size = size } }
  }
}
