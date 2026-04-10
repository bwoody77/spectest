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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
      }

      .overlay {
        if (specEq(vm.visible, true) && specEq(vm.placement, "top")) {
          ZStack {
            if (specEq(vm.visible, true) && specEq(vm.placement, "top")) {
              Text(verbatim: specString(vm.text))
                .font(.body.bold())
                .foregroundStyle(Color(hex: "#f1f5f9"))
            }
          }
        }
      }
      .overlay {
        if (specEq(vm.visible, true) && specEq(vm.placement, "bottom")) {
          ZStack {
            if (specEq(vm.visible, true) && specEq(vm.placement, "bottom")) {
              Text(verbatim: specString(vm.text))
                .font(.body.bold())
                .foregroundStyle(Color(hex: "#f1f5f9"))
            }
          }
        }
      }
      .overlay {
        if (specEq(vm.visible, true) && specEq(vm.placement, "left")) {
          ZStack {
            if (specEq(vm.visible, true) && specEq(vm.placement, "left")) {
              Text(verbatim: specString(vm.text))
                .font(.body.bold())
                .foregroundStyle(Color(hex: "#f1f5f9"))
            }
          }
        }
      }
      .overlay {
        if (specEq(vm.visible, true) && specEq(vm.placement, "right")) {
          ZStack {
            if (specEq(vm.visible, true) && specEq(vm.placement, "right")) {
              Text(verbatim: specString(vm.text))
                .font(.body.bold())
                .foregroundStyle(Color(hex: "#f1f5f9"))
            }
          }
        }
      }
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.text = text; vm.placement = placement }
  }
}
