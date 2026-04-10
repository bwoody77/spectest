import SwiftUI
import SpecRuntime

@Observable
final class RouterAboutViewModel {
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct RouterAboutView: View {
  @State private var vm = RouterAboutViewModel()
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(12)) {
        Text(verbatim: specString("About"))
          .font(.headline.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Text(verbatim: specString("This is the '/about' route. The browser URL changed when you clicked the link."))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        Text(verbatim: specString("Your browser's back button will return to the previous route."))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      }
      .padding(CGFloat(20))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
