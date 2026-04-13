import SwiftUI
import SpecRuntime

@Observable
final class InfoBoxViewModel {
  var title: Any = "Info Box"
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct InfoBoxView: View {
  @State private var vm = InfoBoxViewModel()
  var title: Any = "Info Box"
  init(title: Any = "Info Box") { self._vm = State(initialValue: InfoBoxViewModel()); self.title = title }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(8)) {
        Text(verbatim: specString(vm.title))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        // slot
      }
      .padding(CGFloat(16))
      .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.title, title) { vm.title = title } }
    .task(id: specPropsKey([title])) { if !specEq(vm.title, title) { vm.title = title } }
  }
}
