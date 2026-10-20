import SwiftUI
import SpecRuntime

@Observable
final class RouterNotFoundViewModel {
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct RouterNotFoundView: View {
  @State private var vm = RouterNotFoundViewModel()
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        Text(verbatim: specString("404 — Not Found"))
          .font(.headline.bold())
          .foregroundStyle(Color(hex: "#dc2626"))
        Text(verbatim: specString("No route matched the current path. This is the wildcard fallback."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      }
      .padding(ThemeManager.shared.size("spacing-5"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
