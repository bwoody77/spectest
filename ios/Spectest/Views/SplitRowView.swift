import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class SplitRowViewModel {
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
  var _specSlots: [String: Any] = [:]
}

struct SplitRowView: View {
  @State private var vm = SplitRowViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  var specSlot_left: AnyView? = nil
  var specSlot_right: AnyView? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil, specSlot_left: AnyView? = nil, specSlot_right: AnyView? = nil) { let _m = SplitRowViewModel(); _m.onDispatch = onDispatch; var _sl: [String: Any] = [:]; if let v = specSlot_left { _sl["left"] = v as Any }; if let v = specSlot_right { _sl["right"] = v as Any }; _m._specSlots = _sl; self._vm = State(initialValue: _m); self.onDispatch = onDispatch; self.specSlot_left = specSlot_left; self.specSlot_right = specSlot_right }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-4"))) {
        VStack(alignment: .leading, spacing: 0) {
          (specSlot_left ?? AnyView(EmptyView()))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .specFlexGrow(1)
        VStack(alignment: .leading, spacing: 0) {
          (specSlot_right ?? AnyView(EmptyView()))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .specFlexGrow(1)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
