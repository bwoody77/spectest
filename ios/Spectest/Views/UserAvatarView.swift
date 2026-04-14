import SwiftUI
import SpecRuntime

@Observable
final class UserAvatarViewModel {
  var bgColor: Any? = nil
  var name: Any? = nil
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct UserAvatarView: View {
  @State private var vm = UserAvatarViewModel()
  var bgColor: Any? = nil
  var name: Any? = nil
  init(bgColor: Any? = nil, name: Any? = nil) { self._vm = State(initialValue: UserAvatarViewModel()); self.bgColor = bgColor; self.name = name }
  var body: some View {
    VStack() {
      HStack(alignment: .center) {
        Text(verbatim: specString(vm.name))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.background"))
      }
      .padding(CGFloat(12))
      .background(Color(hex: vm.bgColor as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
      .hoverEffect(.highlight)
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.name, name) { vm.name = name }; if !specEq(vm.bgColor, bgColor) { vm.bgColor = bgColor } }
    .task(id: specPropsKey([name, bgColor])) { if !specEq(vm.name, name) { vm.name = name }; if !specEq(vm.bgColor, bgColor) { vm.bgColor = bgColor } }
  }
}
