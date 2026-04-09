import SwiftUI
import SpecRuntime

@Observable
final class RouterUserViewModel {
  var userId: Any? = nil
}

struct RouterUserView: View {
  @State private var vm = RouterUserViewModel()
  var userId: Any? = nil
  init(userId: Any? = nil) { self._vm = State(initialValue: RouterUserViewModel()); self.userId = userId }
  var body: some View {
    VStack() {
      VStack(spacing: CGFloat(12)) {
        Text(specString("User Profile"))
          .font(.headline.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
        Text(specString("Route: /users/\(specString(vm.userId))"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        Text(specString("The ':id' segment from the URL pattern is extracted into _routeParams.id and passed as a prop."))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
        HStack(alignment: .center, spacing: CGFloat(12)) {
          HStack(alignment: .center, ) {
            Text(specString(((vm.userId) as? Bool ?? false ? (vm.userId as? [Any])?[0 as? Int ?? 0] : "?")))
              .font(.headline.bold())
              .foregroundStyle(Color(hex: "#fff"))
          }
          .frame(width: CGFloat(40))
          .frame(height: CGFloat(40))
          .background(ThemeManager.shared.color("semantic.accent"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
          VStack(spacing: CGFloat(4)) {
            Text(specString("User #\(specString(vm.userId))"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            Text(specString("user\(specString(vm.userId))@example.com"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }

        }
        .padding(CGFloat(16))
        .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      }
      .padding(CGFloat(20))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.userId = userId }
  }
}
