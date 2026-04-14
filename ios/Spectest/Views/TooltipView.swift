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
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
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
          if (specEq(vm.visible, true) && specEq(vm.placement, "top")) {
            Text(verbatim: specString(vm.text))
              .font(.body.bold())
              .foregroundStyle(Color(hex: "#f1f5f9"))
          }
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        .background(Color(hex: "#1e293b"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
        VStack() {
          if (specEq(vm.visible, true) && specEq(vm.placement, "bottom")) {
            Text(verbatim: specString(vm.text))
              .font(.body.bold())
              .foregroundStyle(Color(hex: "#f1f5f9"))
          }
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        .background(Color(hex: "#1e293b"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
        VStack() {
          if (specEq(vm.visible, true) && specEq(vm.placement, "left")) {
            Text(verbatim: specString(vm.text))
              .font(.body.bold())
              .foregroundStyle(Color(hex: "#f1f5f9"))
          }
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        .background(Color(hex: "#1e293b"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
        VStack() {
          if (specEq(vm.visible, true) && specEq(vm.placement, "right")) {
            Text(verbatim: specString(vm.text))
              .font(.body.bold())
              .foregroundStyle(Color(hex: "#f1f5f9"))
          }
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        .background(Color(hex: "#1e293b"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.text, text) { vm.text = text }; if !specEq(vm.placement, placement) { vm.placement = placement } }
    .task(id: specPropsKey([text, placement])) { if !specEq(vm.text, text) { vm.text = text }; if !specEq(vm.placement, placement) { vm.placement = placement } }
  }
}
