import SwiftUI
import SpecRuntime

@Observable
final class SplitRowViewModel {
}

struct SplitRowView: View {
  @State private var vm = SplitRowViewModel()
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(16)) {
        VStack() {
          // slot
        }
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
        VStack() {
          // slot
        }
        .frame(minHeight: CGFloat(0))
        .frame(minWidth: CGFloat(0))
        .frame(maxWidth: .infinity)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
