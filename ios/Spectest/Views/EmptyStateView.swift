import SwiftUI
import SpecRuntime

@Observable
final class EmptyStateViewModel {
  var description: Any = ""
  var message: Any? = nil
}

struct EmptyStateView: View {
  @State private var vm = EmptyStateViewModel()
  var description: Any = ""
  var message: Any? = nil
  init(description: Any = "", message: Any? = nil) { self._vm = State(initialValue: EmptyStateViewModel()); self.description = description; self.message = message }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(8)) {
        Image(systemName: specIconName(specString("inbox")))
          .font(.system(size: specPx("48px")))
          .foregroundStyle(Color(hex: "#92a2b9" as? String ?? "#000"))
        Text(specString(vm.message))
          .font(.headline.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Text(specString(vm.description))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
      }
      .padding(CGFloat(24))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.message = message; vm.description = description }
  }
}
