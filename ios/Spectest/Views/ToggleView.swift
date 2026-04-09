import SwiftUI
import SpecRuntime

@Observable
final class ToggleViewModel {
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
}

struct ToggleView: View {
  @State private var vm = ToggleViewModel()
  var checked: Any = false
  var disabled: Any = false
  var label: Any? = nil
  init(checked: Any = false, disabled: Any = false, label: Any? = nil) { self._vm = State(initialValue: ToggleViewModel()); self.checked = checked; self.disabled = disabled; self.label = label }
  var body: some View {
    VStack() {
      Button(action: { /* event callback */ }) {
        Text(specString(vm.label))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        VStack() {
          VStack() {
          }
          .frame(width: CGFloat(18))
          .frame(height: CGFloat(18))
          .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(9999)))
        }
        .frame(width: CGFloat(44))
        .frame(height: CGFloat(24))
        .background(Color(hex: ({ () -> Any in switch specString(vm.checked) {
case specString(true): return "#4f46e5"
default: return "#cbd5e1"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(999)))
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
    .onAppear { vm.label = label; vm.checked = checked; vm.disabled = disabled }
  }
}
