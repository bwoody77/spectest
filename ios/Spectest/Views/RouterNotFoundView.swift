import SwiftUI
import SpecRuntime

@Observable
final class RouterNotFoundViewModel {
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct RouterNotFoundView: View {
  @State private var vm = RouterNotFoundViewModel()
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(12)) {
        Text(specString("404 — Not Found"))
          .font(.headline.bold())
          .foregroundStyle(Color(hex: "#dc2626"))
        Text(specString("No route matched the current path. This is the wildcard fallback."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      }
      .padding(CGFloat(20))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
