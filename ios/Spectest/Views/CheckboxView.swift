import SwiftUI
import SpecRuntime

@Observable
final class CheckboxViewModel {
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct CheckboxView: View {
  @State private var vm = CheckboxViewModel()
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  init(checked: Any = false, disabled: Any = false, label: Any? = nil) { self._vm = State(initialValue: CheckboxViewModel()); self.checked = checked; self.disabled = disabled; self.label = label }
  var body: some View {
    VStack() {
      Button(action: {  }) {
        HStack(alignment: .center) {
          VStack() {
            if specEq(vm.checked, true) {
              Image(systemName: specIconName(specString("check")))
                .font(.system(size: specPx("14px")))
                .foregroundStyle(ThemeManager.shared.color("semantic.background"))
            }
          }

        }
        .frame(width: CGFloat(18))
        .specFrameHeight(CGFloat(18))
        .background(({ () -> Color in switch specString(vm.checked) {
case specString(true): return ThemeManager.shared.color("checkbox-checkedBg")
default: return Color.clear
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("checkbox-radius")))
        Text(verbatim: specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      }
      .background(Color.clear)
      .opacity(specPx(({ () -> Any in switch specString(vm.disabled) {
case specString(true): return 0.5
default: return 1
} })()))
      .background(Color.clear)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.checked, checked) { vm.checked = checked }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
    .task(id: specPropsKey([label, checked, disabled])) { if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.checked, checked) { vm.checked = checked }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled } }
  }
}
