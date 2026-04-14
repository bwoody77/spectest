import SwiftUI
import SpecRuntime

@Observable
final class RouterUserViewModel {
  var userId: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct RouterUserView: View {
  @State private var vm = RouterUserViewModel()
  var userId: Any? = nil
  init(userId: Any? = nil) { self._vm = State(initialValue: RouterUserViewModel()); self.userId = userId }
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-3")) {
        Text(verbatim: specString("User Profile"))
          .font(.headline.bold())
          .foregroundStyle(ThemeManager.shared.color("text-primary"))
        Text(verbatim: specString("Route: /users/\(specString(vm.userId))"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        Text(verbatim: specString("The ':id' segment from the URL pattern is extracted into _routeParams.id and passed as a prop."))
          .font(.callout.bold())
          .foregroundStyle(ThemeManager.shared.color("text-secondary"))
        HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
          HStack(alignment: .center) {
            Text(verbatim: ({ () -> String in
          if (vm.userId) as? Bool ?? false { return specString((vm.userId as? [Any])?[0]) }
          return specString("?")
        })())
              .font(.headline.bold())
              .foregroundStyle(Color(hex: "#fff"))
          }
          .frame(width: CGFloat(40))
          .specFrameHeight(CGFloat(40))
          .background(ThemeManager.shared.color("primary"), in: RoundedRectangle(cornerRadius: CGFloat(0)))
          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
            Text(verbatim: specString("User #\(specString(vm.userId))"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-primary"))
            Text(verbatim: specString("user\(specString(vm.userId))@example.com"))
              .font(.callout.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }

        }
        .padding(ThemeManager.shared.size("spacing-4"))
        .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
      }
      .padding(ThemeManager.shared.size("spacing-5"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.userId, userId) { vm.userId = userId } }
    .task(id: specPropsKey([userId])) { if !specEq(vm.userId, userId) { vm.userId = userId } }
  }
}
