import SwiftUI
import SpecRuntime

@Observable
final class RouterHomeViewModel {
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct RouterHomeView: View {
  @State private var vm = RouterHomeViewModel()
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        Text(verbatim: specString("Home Page"))
          .font(.headline.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("This is the root route ('/'). Navigate using the links in the sidebar."))
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
