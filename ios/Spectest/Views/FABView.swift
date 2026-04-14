import SwiftUI
import SpecRuntime

@Observable
final class FABViewModel {
  var icon: Any = "plus"
  var label: Any = ""
  var size: Any = "md"
  var btnSize: Any { ({ () -> Any in switch specString(size) {
case specString("sm"): return "40px"
case specString("lg"): return "64px"
default: return "56px"
} })() }
  var iconSize: Any { ({ () -> Any in switch specString(size) {
case specString("sm"): return "18px"
case specString("lg"): return "28px"
default: return "24px"
} })() }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct FABView: View {
  @State private var vm = FABViewModel()
  var icon: Any = "plus"
  var label: Any = ""
  var size: Any = "md"
  init(icon: Any = "plus", label: Any = "", size: Any = "md") { self._vm = State(initialValue: FABViewModel()); self.icon = icon; self.label = label; self.size = size }
  var body: some View {
    VStack() {
      VStack() {
        HStack(alignment: .center, spacing: CGFloat(8)) {
          Image(systemName: specIconName(specString(vm.icon)))
            .font(.system(size: specPx(vm.iconSize)))
            .foregroundStyle(Color(hex: "white" as? String ?? "transparent"))
          Text(verbatim: specString(vm.label))
            .font(.body.bold())
            .foregroundStyle(Color.white)
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, specPx((specNeq(vm.label, "") ? "16px" : "0px")))
        .padding(.trailing, specPx((specNeq(vm.label, "") ? "16px" : "0px")))
        .frame(width: specPx((specNeq(vm.label, "") ? "auto" : vm.btnSize)))
        .specFrameHeight(specPx(vm.btnSize))
        .frame(minWidth: specPx(vm.btnSize))
        .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: specPx((specNeq(vm.label, "") ? "28px" : "50%"))))
        .hoverEffect(.highlight)
        .onTapGesture { /* event callback */ }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.icon, icon) { vm.icon = icon }; if !specEq(vm.size, size) { vm.size = size }; if !specEq(vm.label, label) { vm.label = label } }
    .task(id: specPropsKey([icon, size, label])) { if !specEq(vm.icon, icon) { vm.icon = icon }; if !specEq(vm.size, size) { vm.size = size }; if !specEq(vm.label, label) { vm.label = label } }
  }
}
