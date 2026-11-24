import SwiftUI
import SpecRuntime

@Observable
@MainActor
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
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct FABView: View {
  @State private var vm = FABViewModel()
  var icon: Any = "plus"
  var label: Any = ""
  var size: Any = "md"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(icon: Any = "plus", label: Any = "", size: Any = "md", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = FABViewModel(); _m.icon = icon; _m.label = label; _m.size = size; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.icon = icon; self.label = label; self.size = size; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(icon) + "\u{1}" + specChangeKey(label) + "\u{1}" + specChangeKey(size) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        Button(action: { specClick { vm.dispatch("click") } }) {
        HStack(alignment: .center, spacing: CGFloat(8)) {
          Spacer(minLength: 0)
          Group {
            if !specString(vm.icon).trimmingCharacters(in: .whitespaces).isEmpty {
              Image(systemName: specIconName(specString(vm.icon)))
                .font(.system(size: specPx(vm.iconSize)))
                .foregroundStyle(Color(hex: "white" as? String ?? "transparent"))
            }
          }
          if specNeq(vm.label, "") {
          Text(verbatim: specString(vm.label))
            .font(.body)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-md-strong-fontWeight")))
            .foregroundStyle(Color.white)
          }
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, specPx((specNeq(vm.label, "") ? ThemeManager.shared.rawToken("spacing-4") : "0px")))
        .padding(.trailing, specPx((specNeq(vm.label, "") ? ThemeManager.shared.rawToken("spacing-4") : "0px")))
        .specFrameWidth((specNeq(vm.label, "") ? "auto" : vm.btnSize), alignment: .center)
        .specFrameHeight(specPx(vm.btnSize), alignment: .center)
        .frame(minWidth: specPx(vm.btnSize), alignment: .center)
        .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: specPx((specNeq(vm.label, "") ? "28px" : "50%"))))
        .specBoxShadow(ThemeManager.shared.rawToken("elevation-raised"), radius: specPx((specNeq(vm.label, "") ? "28px" : "50%")))
        .hoverEffect(.highlight)
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .specFullBasis(specString((specNeq(vm.label, "") ? "auto" : vm.btnSize)) == "100%")
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.icon = icon
      vm.label = label
      vm.size = size
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.icon, icon) { vm.icon = icon }; if !specSame(vm.size, size) { vm.size = size }; if !specSame(vm.label, label) { vm.label = label } }
    .task(id: specPropsKey([icon, size, label])) { if !specSame(vm.icon, icon) { vm.icon = icon }; if !specSame(vm.size, size) { vm.size = size }; if !specSame(vm.label, label) { vm.label = label } }
  }
}
