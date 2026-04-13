import SwiftUI
import SpecRuntime

@Observable
final class ToggleViewModel {
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct ToggleView: View {
  @State private var vm = ToggleViewModel()
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  init(checked: Any = false, disabled: Any = false, label: Any? = nil) { self._vm = State(initialValue: ToggleViewModel()); self.checked = checked; self.disabled = disabled; self.label = label }
  var body: some View {
    VStack() {
      Button(action: {  }) {
        Text(verbatim: specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        VStack() {
        }
        .frame(width: CGFloat(44))
        .specFrameHeight(CGFloat(24))
        .background(Color(hex: ({ () -> Any in switch specString(vm.checked) {
case specString(true): return "#4f46e5"
default: return "#cbd5e1"
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: CGFloat(999)))
        .overlay {
        }
      }
      .padding(CGFloat(0))
      .background(Color.clear)
      .opacity(specPx(({ () -> Any in switch specString(vm.disabled) {
case specString(true): return 0.5
default: return 1
} })()))
      .background(Color.clear)
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.checked, checked) { vm.checked = checked }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
    .task(id: specPropsKey([label, checked, disabled])) { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.checked, checked) { vm.checked = checked }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
  }
}
