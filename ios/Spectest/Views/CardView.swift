import SwiftUI
import SpecRuntime

@Observable
final class CardViewModel {
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
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
