import SwiftUI
import SpecRuntime

@Observable
final class CountDisplayViewModel {
  var value: Any? = nil
  var changes: Any = 0
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct CountDisplayView: View {
  @State private var vm = CountDisplayViewModel()
  var value: Any? = nil
  init(value: Any? = nil) { self._vm = State(initialValue: CountDisplayViewModel()); self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(4)) {
        Text(verbatim: specString("Received value: \(specString(vm.value))"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Text(verbatim: specString("@watch fired \(specString(vm.changes)) time(s)"))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
      }
      .padding(CGFloat(12))
      .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.value = value }
  }
}
