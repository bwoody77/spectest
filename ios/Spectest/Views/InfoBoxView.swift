import SwiftUI
import SpecRuntime

@Observable
final class InfoBoxViewModel {
  var title: Any = "Info Box"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct InfoBoxView: View {
  @State private var vm = InfoBoxViewModel()
  var title: Any = "Info Box"
  init(title: Any = "Info Box") { self._vm = State(initialValue: InfoBoxViewModel()); self.title = title }
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-2")) {
        Text(verbatim: specString(vm.title))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        // slot
      }
      .padding(ThemeManager.shared.size("spacing-4"))
      .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.title, title) { vm.title = title } }
    .task(id: specPropsKey([title])) { if !specEq(vm.title, title) { vm.title = title } }
  }
}
