import SwiftUI
import SpecRuntime

@Observable
final class RadioViewModel {
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  var value: Any = ""
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
      Button(action: { /* event callback */ }) {
        HStack(alignment: .center, ) {
          VStack() {
            if (specString(vm.checked) == specString(true)) {
            }
          }
          .frame(width: CGFloat(8))
          .frame(height: CGFloat(8))
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(9999)))
        }
        .frame(width: CGFloat(18))
        .frame(height: CGFloat(18))
        .background(Color(hex: ({ () -> Any in switch specString(vm.checked) {
case specString(true): return "#4f46e5"
default: return "transparent"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(9999)))
        Text(specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(.secondary)
      }
      .padding(CGFloat(0))
      .background(Color.clear)
      .opacity(specPx(({ () -> Any in switch specString(vm.disabled) {
case specString(true): return 0.5
default: return 1
} })()))
      .background(Color.clear)
    }
    .foregroundStyle(.primary)
    .onAppear { vm.label = label; vm.value = value; vm.checked = checked; vm.disabled = disabled }
  }
}
