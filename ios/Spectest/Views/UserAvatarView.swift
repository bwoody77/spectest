import SwiftUI
import SpecRuntime

@Observable
final class UserAvatarViewModel {
  var bgColor: Any? = nil
  var name: Any? = nil
}

struct UserAvatarView: View {
  @State private var vm = UserAvatarViewModel()
  var bgColor: Any? = nil
  var name: Any? = nil
  init(bgColor: Any? = nil, name: Any? = nil) { self._vm = State(initialValue: UserAvatarViewModel()); self.bgColor = bgColor; self.name = name }
  var body: some View {
    VStack() {
      HStack(alignment: .center, ) {
        Text(specString(vm.name))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.on-destructive"))
      }
      .padding(CGFloat(12))
      .background(Color(hex: vm.bgColor as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.name = name; vm.bgColor = bgColor }
  }
}
