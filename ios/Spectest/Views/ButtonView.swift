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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
          .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.variant) {
case specString("primary"): return "#fff"
case specString("secondary"): return "#334155"
case specString("ghost"): return "#64748b"
case specString("destructive"): return "#fff"
default: return "#fff"
} })() as? String ?? "transparent"))
      }
      .padding(.leading, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "8px"
case specString("lg"): return "24px"
default: return "18px"
} })()))
      .padding(.trailing, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "8px"
case specString("lg"): return "24px"
default: return "18px"
} })()))
      .padding(.top, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "4px"
case specString("lg"): return "12px"
default: return "8px"
} })()))
      .padding(.bottom, specPx(({ () -> Any in switch specString(vm.size) {
case specString("sm"): return "4px"
case specString("lg"): return "12px"
default: return "8px"
} })()))
      .opacity(specPx(({ () -> Any in switch specString(vm.loading) {
case specString(true): return 0.7
default: return ({ () -> Any in switch specString(vm.disabled) {
case specString(true): return 0.5
default: return 1
} })()
} })()))
      .background(Color(hex: ({ () -> Any in switch specString(vm.pressed) {
case specString(true): return ({ () -> Any in switch specString(vm.variant) {
case specString("primary"): return "#4338ca"
case specString("secondary"): return "#e2e8f0"
case specString("ghost"): return "#f1f5f9"
case specString("destructive"): return "#dc2626"
default: return "#4338ca"
} })()
default: return ({ () -> Any in switch specString(vm.variant) {
case specString("primary"): return "#4f46e5"
case specString("secondary"): return "#f1f5f9"
case specString("ghost"): return "transparent"
case specString("destructive"): return "#ef4444"
default: return "#4f46e5"
} })()
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.variant, variant) { vm.variant = variant }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.loading, loading) { vm.loading = loading }; if !specEq(vm.pressed, pressed) { vm.pressed = pressed }; if !specEq(vm.size, size) { vm.size = size } }
    .task(id: specPropsKey([label, variant, disabled, loading, pressed, size])) { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.variant, variant) { vm.variant = variant }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.loading, loading) { vm.loading = loading }; if !specEq(vm.pressed, pressed) { vm.pressed = pressed }; if !specEq(vm.size, size) { vm.size = size } }
  }
}
