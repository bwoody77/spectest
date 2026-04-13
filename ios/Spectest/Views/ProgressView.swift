import SwiftUI
import SpecRuntime

@Observable
final class ProgressViewModel {
  var label: Any = ""
  var value: Any = 0
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
        .background(Color(hex: "#3b82f6"), in: RoundedRectangle(cornerRadius: CGFloat(4)))
      }
      .frame(height: CGFloat(8))
      .background(Color(hex: "#e2e8f0"), in: RoundedRectangle(cornerRadius: CGFloat(4)))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.label, label) { vm.label = label } }
    .task(id: specPropsKey([value, label])) { if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.label, label) { vm.label = label } }
  }
}
