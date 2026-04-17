import SwiftUI
import SpecRuntime

@Observable
final class SplitRowViewModel {
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct SplitRowView: View {
  @State private var vm = SplitRowViewModel()
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-4")) {
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
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
