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
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
    }
    .foregroundStyle(.primary)
  }
}
