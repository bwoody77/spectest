import SwiftUI
import SpecRuntime

@Observable
final class CheckboxViewModel {
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
        HStack(alignment: .center, ) {
          VStack() {
            if specEq(vm.checked, true) {
              Image(systemName: specIconName(specString("check")))
                .font(.system(size: specPx("14px")))
                .foregroundStyle(Color(hex: "#ffffff" as? String ?? "#000"))
            }
          }

        }
        .frame(width: CGFloat(18))
        .frame(height: CGFloat(18))
        .background(Color(hex: ({ () -> Any in switch specString(vm.checked) {
case specString(true): return "#4f46e5"
default: return "transparent"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(5)))
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
    .onAppear { vm.label = label; vm.checked = checked; vm.disabled = disabled }
  }
}
