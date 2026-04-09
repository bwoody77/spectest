import SwiftUI
import SpecRuntime

@Observable
final class CountDisplayViewModel {
  var value: Any? = nil
  var changes: Any = 0
}

struct CountDisplayView: View {
  @State private var vm = CountDisplayViewModel()
  var value: Any? = nil
  init(value: Any? = nil) { self._vm = State(initialValue: CountDisplayViewModel()); self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(4)) {
        Text(specString("Received value: \(specString(vm.value))"))
          .font(.body.bold())
          .foregroundStyle(.primary)
        Text(specString("@watch fired \(specString(vm.changes)) time(s)"))
          .font(.callout.bold())
          .foregroundStyle(Color.blue)
      }
      .padding(CGFloat(12))
      .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.value = value }
  }
}
