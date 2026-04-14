import SwiftUI
import SpecRuntime

@Observable
final class RadioViewModel {
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  var value: Any = ""
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct RadioView: View {
  @State private var vm = RadioViewModel()
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  var value: Any = ""
  init(checked: Any = false, disabled: Any = false, label: Any? = nil, value: Any = "") { self._vm = State(initialValue: RadioViewModel()); self.checked = checked; self.disabled = disabled; self.label = label; self.value = value }
  var body: some View {
    VStack() {
      Button(action: {  }) {
        HStack(alignment: .center, ) {
          VStack() {
            if specEq(vm.checked, true) {
            }
          }
          .frame(width: CGFloat(8))
          .specFrameHeight(CGFloat(8))
          .background(ThemeManager.shared.color("semantic.background"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
        }
        .frame(width: CGFloat(18))
        .specFrameHeight(CGFloat(18))
        .background(Color(hex: ({ () -> Any in switch specString(vm.checked) {
case specString(true): return "#4f46e5"
default: return "transparent"
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
        Text(verbatim: specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
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
    .onAppear { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.checked, checked) { vm.checked = checked }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
    .task(id: specPropsKey([label, value, checked, disabled])) { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.checked, checked) { vm.checked = checked }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
  }
}
