import SwiftUI
import SpecRuntime

@Observable
final class ProgressViewModel {
  var label: Any = ""
  var value: Any = 0
}

struct ProgressView: View {
  @State private var vm = ProgressViewModel()
  var label: Any = ""
  var value: Any = 0
  init(label: Any = "", value: Any = 0) { self._vm = State(initialValue: ProgressViewModel()); self.label = label; self.value = value }
  var body: some View {
    VStack() {
      VStack() {
        VStack() {
        }
        .frame(width: specPx(({ () -> Any in switch specString(vm.value) {
case specString(0): return "0%"
default: return "\(specString(vm.value))%"
} })()))
        .frame(height: CGFloat(8))
        .background(Color.blue, in: RoundedRectangle(cornerRadius: CGFloat(4)))
      }
      .frame(height: CGFloat(8))
      .background(Color(.separator), in: RoundedRectangle(cornerRadius: CGFloat(4)))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.value = value; vm.label = label }
  }
}
