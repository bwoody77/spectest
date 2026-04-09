import SwiftUI
import SpecRuntime

@Observable
final class RouterAboutViewModel {
}

struct RouterAboutView: View {
  @State private var vm = RouterAboutViewModel()
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(12)) {
        Text(specString("About"))
          .font(.headline.bold())
          .foregroundStyle(.primary)
        Text(specString("This is the '/about' route. The browser URL changed when you clicked the link."))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        Text(specString("Your browser's back button will return to the previous route."))
          .font(.callout.bold())
          .foregroundStyle(.secondary)
      }
      .padding(CGFloat(20))
    }
    .foregroundStyle(.primary)
  }
}
