import SwiftUI
import SpecRuntime

@Observable
final class ProductStatusBadgeViewModel {
  var status: Any? = nil
}

struct ProductStatusBadgeView: View {
  @State private var vm = ProductStatusBadgeViewModel()
  var status: Any? = nil
  init(status: Any? = nil) { self._vm = State(initialValue: ProductStatusBadgeViewModel()); self.status = status }
  var body: some View {
    VStack() {
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
    .foregroundStyle(.primary)
    .onAppear { vm.status = status }
  }
}
