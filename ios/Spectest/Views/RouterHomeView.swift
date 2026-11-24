import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class RouterHomeViewModel {
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct RouterHomeView: View {
  @State private var vm = RouterHomeViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = RouterHomeViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
        Text(verbatim: specString("Home Page"))
          .font(.title2)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-heading-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("This is the root route ('/'). Navigate using the links in the sidebar."))
          .font(.body)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      }
      .padding(specPx(ThemeManager.shared.rawToken("spacing-5")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
