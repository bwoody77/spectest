import SwiftUI
import SpecRuntime

@Observable
final class InfoBoxViewModel {
  var title: Any = "Info Box"
}

struct InfoBoxView: View {
  @State private var vm = InfoBoxViewModel()
  var title: Any = "Info Box"
  init(title: Any = "Info Box") { self._vm = State(initialValue: InfoBoxViewModel()); self.title = title }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(8)) {
        Text(specString(vm.title))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        // slot
      }
      .padding(CGFloat(16))
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.title = title }
  }
}
