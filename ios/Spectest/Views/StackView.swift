import SwiftUI
import SpecRuntime

@Observable
final class StackViewModel {
  var align: Any = "stretch"
  var direction: Any = "vertical"
  var gap: Any = "0"
  var wrap: Any = false
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct StackView: View {
  @State private var vm = StackViewModel()
  var align: Any = "stretch"
  var direction: Any = "vertical"
  var gap: Any = "0"
  var wrap: Any = false
  init(align: Any = "stretch", direction: Any = "vertical", gap: Any = "0", wrap: Any = false) { self._vm = State(initialValue: StackViewModel()); self.align = align; self.direction = direction; self.gap = gap; self.wrap = wrap }
  var body: some View {
    VStack() {
      VStack() {
        if specEq(vm.direction, "vertical") {
          // slot
        }
      }

      HStack(alignment: .center, ) {
        if specEq(vm.direction, "horizontal") {
          // slot
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.direction, direction) { vm.direction = direction }; if !specEq(vm.gap, gap) { vm.gap = gap }; if !specEq(vm.align, align) { vm.align = align }; if !specEq(vm.wrap, wrap) { vm.wrap = wrap } }
    .task(id: specPropsKey([direction, gap, align, wrap])) { if !specEq(vm.direction, direction) { vm.direction = direction }; if !specEq(vm.gap, gap) { vm.gap = gap }; if !specEq(vm.align, align) { vm.align = align }; if !specEq(vm.wrap, wrap) { vm.wrap = wrap } }
  }
}
