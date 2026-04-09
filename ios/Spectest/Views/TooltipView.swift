import SwiftUI
import SpecRuntime

@Observable
final class TooltipViewModel {
  var placement: Any = "top"
  var text: Any = ""
  var visible: Any = false
  func showTip() {
    // unsupported: delay
  }
  func hideTip() {
    // unsupported: clear-delay
    visible = false
  }
}

struct TooltipView: View {
  @State private var vm = TooltipViewModel()
  var placement: Any = "top"
  var text: Any = ""
  init(placement: Any = "top", text: Any = "") { self._vm = State(initialValue: TooltipViewModel()); self.placement = placement; self.text = text }
  var body: some View {
    VStack() {
      VStack() {
        // slot
        VStack() {
          if ((specString(vm.visible) == specString(true)) && (specString(vm.placement) == specString("top"))) {
            Text(specString(vm.text))
              .font(.body.bold())
              .foregroundStyle(Color(.tertiarySystemGroupedBackground))
          }
        }
        .padding(CGFloat(8))
        .background(Color(hex: "#1e293b"), in: RoundedRectangle(cornerRadius: CGFloat(6)))
        VStack() {
          if ((specString(vm.visible) == specString(true)) && (specString(vm.placement) == specString("bottom"))) {
            Text(specString(vm.text))
              .font(.body.bold())
              .foregroundStyle(Color(.tertiarySystemGroupedBackground))
          }
        }
        .padding(CGFloat(8))
        .background(Color(hex: "#1e293b"), in: RoundedRectangle(cornerRadius: CGFloat(6)))
        VStack() {
          if ((specString(vm.visible) == specString(true)) && (specString(vm.placement) == specString("left"))) {
            Text(specString(vm.text))
              .font(.body.bold())
              .foregroundStyle(Color(.tertiarySystemGroupedBackground))
          }
        }
        .padding(CGFloat(8))
        .background(Color(hex: "#1e293b"), in: RoundedRectangle(cornerRadius: CGFloat(6)))
        VStack() {
          if ((specString(vm.visible) == specString(true)) && (specString(vm.placement) == specString("right"))) {
            Text(specString(vm.text))
              .font(.body.bold())
              .foregroundStyle(Color(.tertiarySystemGroupedBackground))
          }
        }
        .padding(CGFloat(8))
        .background(Color(hex: "#1e293b"), in: RoundedRectangle(cornerRadius: CGFloat(6)))
      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.text = text; vm.placement = placement }
  }
}
