import SwiftUI
import SpecRuntime

@Observable
final class EmptyStateViewModel {
  var description: Any = ""
  var message: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct EmptyStateView: View {
  @State private var vm = EmptyStateViewModel()
  var description: Any = ""
  var message: Any? = nil
  init(description: Any = "", message: Any? = nil) { self._vm = State(initialValue: EmptyStateViewModel()); self.description = description; self.message = message }
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-2")) {
        Image(systemName: specIconName(specString("inbox")))
          .font(.system(size: specPx(ThemeManager.shared.resolve("icon-xxl"))))
          .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
        Text(verbatim: specString(vm.message))
          .font(.headline.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString(vm.description))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
      }
      .padding(ThemeManager.shared.size("spacing-6"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.description, description) { vm.description = description } }
    .task(id: specPropsKey([message, description])) { if !specEq(vm.message, message) { vm.message = message }; if !specEq(vm.description, description) { vm.description = description } }
  }
}
