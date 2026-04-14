import SwiftUI
import SpecRuntime

@Observable
final class SplitRowViewModel {
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct SplitRowView: View {
  @State private var vm = SplitRowViewModel()
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(16)) {
        VStack() {
          // slot
        }
        .frame(maxWidth: .infinity)
        VStack() {
          // slot
        }
        .frame(maxWidth: .infinity)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
