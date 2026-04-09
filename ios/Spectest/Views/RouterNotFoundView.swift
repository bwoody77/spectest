import SwiftUI
import SpecRuntime

@Observable
final class RouterNotFoundViewModel {
}

struct RouterNotFoundView: View {
  @State private var vm = RouterNotFoundViewModel()
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(12)) {
        Text(specString("404 — Not Found"))
          .font(.headline.bold())
          .foregroundStyle(Color.red)
        Text(specString("No route matched the current path. This is the wildcard fallback."))
          .font(.body.bold())
          .foregroundStyle(.secondary)
      }
      .padding(CGFloat(20))
    }
    .foregroundStyle(.primary)
  }
}
