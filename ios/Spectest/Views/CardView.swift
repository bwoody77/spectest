import SwiftUI
import SpecRuntime

@Observable
final class CardViewModel {
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct CardView: View {
  @State private var vm = CardViewModel()
  var body: some View {
    VStack() {
      VStack() {
        // slot
      }
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
