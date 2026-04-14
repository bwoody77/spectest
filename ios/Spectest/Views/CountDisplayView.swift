import SwiftUI
import SpecRuntime

@Observable
final class CountDisplayViewModel {
  var value: Any? = nil
  var changes: Any = 0
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct CountDisplayView: View {
  @State private var vm = CountDisplayViewModel()
  var value: Any? = nil
  init(value: Any? = nil) { self._vm = State(initialValue: CountDisplayViewModel()); self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-1")) {
        Text(verbatim: specString("Received value: \(specString(vm.value))"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("@watch fired \(specString(vm.changes)) time(s)"))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("interactive"))
      }
      .padding(ThemeManager.shared.size("spacing-3"))
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.value, value) { vm.value = value } }
    .task(id: specPropsKey([value])) { if !specEq(vm.value, value) { vm.value = value } }
  }
}
