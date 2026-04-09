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
          .foregroundStyle(.primary)
        Text(specString("Route: /users/\(specString(vm.userId))"))
          .font(.body.bold())
          .foregroundStyle(.secondary)
        Text(specString("The ':id' segment from the URL pattern is extracted into _routeParams.id and passed as a prop."))
          .font(.callout.bold())
          .foregroundStyle(.secondary)
        HStack(alignment: .center, spacing: CGFloat(12)) {
          HStack(alignment: .center, ) {
            Text(specString(((vm.userId) as? Bool ?? false ? (vm.userId as? [Any])?[0 as? Int ?? 0] : "?")))
              .font(.headline.bold())
              .foregroundStyle(Color(.secondarySystemGroupedBackground))
          }
          .frame(width: CGFloat(40))
          .frame(height: CGFloat(40))
          .background(Color.blue, in: RoundedRectangle(cornerRadius: CGFloat(0)))
          VStack(spacing: CGFloat(4)) {
            Text(specString("User #\(specString(vm.userId))"))
              .font(.body.bold())
              .foregroundStyle(.primary)
            Text(specString("user\(specString(vm.userId))@example.com"))
              .font(.callout.bold())
              .foregroundStyle(.secondary)
          }

        }
        .padding(CGFloat(16))
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: CGFloat(8)))
      }
      .padding(CGFloat(20))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.userId = userId }
  }
}
