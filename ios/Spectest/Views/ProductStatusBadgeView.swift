import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class ProductStatusBadgeViewModel {
  var status: Any? = nil
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct ProductStatusBadgeView: View {
  @State private var vm = ProductStatusBadgeViewModel()
  var status: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(status: Any? = nil, onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = ProductStatusBadgeViewModel(); _m.status = status; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.status = status; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(status) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      Text(specString(({ () -> Any in switch specString(vm.status) {
case specString("active"): return "Active"
case specString("out-of-stock"): return "Out of Stock"
case specString("discontinued"): return "Discontinued"
default: return vm.status
} })()))
        .font(.caption.weight(.medium))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(specBadgeForeground(specString(({ () -> Any in switch specString(vm.status) {
case specString("active"): return "success"
case specString("out-of-stock"): return "warning"
case specString("discontinued"): return "error"
default: return "neutral"
} })())))
        .background(specBadgeBackground(specString(({ () -> Any in switch specString(vm.status) {
case specString("active"): return "success"
case specString("out-of-stock"): return "warning"
case specString("discontinued"): return "error"
default: return "neutral"
} })())), in: Capsule())
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.status = status
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.status, status) { vm.status = status } }
    .task(id: specPropsKey([status])) { if !specSame(vm.status, status) { vm.status = status } }
  }
}
