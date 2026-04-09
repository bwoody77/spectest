import SwiftUI
import SpecRuntime

@Observable
final class CardViewModel {
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct CardView: View {
  @State private var vm = CardViewModel()
  var body: some View {
    VStack() {
      VStack() {
        // slot
      }
      .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
