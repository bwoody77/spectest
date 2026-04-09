import SwiftUI
import SpecRuntime

@Observable
final class StackViewModel {
  var align: Any = "stretch"
  var direction: Any = "vertical"
  var gap: Any = "0"
  var wrap: Any = false
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
        if (specString(vm.direction) == specString("vertical")) {
          // slot
        }
      }

      HStack(alignment: .center, ) {
        if (specString(vm.direction) == specString("horizontal")) {
          // slot
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.direction = direction; vm.gap = gap; vm.align = align; vm.wrap = wrap }
  }
}
