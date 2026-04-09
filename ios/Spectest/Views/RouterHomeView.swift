import SwiftUI
import SpecRuntime

@Observable
final class RouterHomeViewModel {
}

struct RouterHomeView: View {
  @State private var vm = RouterHomeViewModel()
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(12)) {
        Text(specString("Home Page"))
          .font(.headline.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Text(specString("This is the root route ('/'). Navigate using the links in the sidebar."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      }
      .padding(CGFloat(20))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
