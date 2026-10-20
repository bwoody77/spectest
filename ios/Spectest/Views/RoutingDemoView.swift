import SwiftUI
import SpecRuntime

@Observable
final class RoutingDemoViewModel {
  var _routePath: Any = "/"
  var _routeParams: Any = [String: Any]()
  func navigate(_ path: Any) {
    _routePath = path
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct RoutingDemoView: View {
  @State private var vm = RoutingDemoViewModel()
  var body: some View {
    HStack(alignment: .center, spacing: CGFloat(0)) {
      VStack(spacing: ThemeManager.shared.size("spacing-1")) {
        Text(verbatim: specString("Navigation"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
        Button(action: { vm.navigate("/") }) {
        VStack() {
          Text(verbatim: specString("Home"))
            .font(.callout.bold())
            .foregroundStyle((specEq(vm._routePath, "/") ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("text-primary")))
        }
        .background((specEq(vm._routePath, "/") ? Color(hex: specAdd(ThemeManager.shared.resolve("primary"), "22") as? String ?? "transparent") : Color.clear), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
        Button(action: { vm.navigate("/about") }) {
        VStack() {
          Text(verbatim: specString("About"))
            .font(.callout.bold())
            .foregroundStyle((specEq(vm._routePath, "/about") ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("text-primary")))
        }
        .background((specEq(vm._routePath, "/about") ? Color(hex: specAdd(ThemeManager.shared.resolve("primary"), "22") as? String ?? "transparent") : Color.clear), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
        Text(verbatim: specString("Users"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
        ForEach(Array(specArr([["id": "1" as Any] as [String: Any], ["id": "2" as Any] as [String: Any], ["id": "3" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, user in
          Button(action: { vm.navigate(specAdd("/users/", specGet(user, "id"))) }) {
          VStack() {
            Text(verbatim: specString("User #\(specString(specGet(user, "id")))"))
              .font(.callout.bold())
              .foregroundStyle((specEq(vm._routePath, specAdd("/users/", specGet(user, "id"))) ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("text-primary")))
          }
          .background((specEq(vm._routePath, specAdd("/users/", specGet(user, "id"))) ? Color(hex: specAdd(ThemeManager.shared.resolve("primary"), "22") as? String ?? "transparent") : Color.clear), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
          }
          .buttonStyle(.plain)
        }
        Button(action: { vm.navigate("/nowhere") }) {
        VStack() {
          Text(verbatim: specString("Unknown route →"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: "#dc2626"))
        }
        .background((specEq(vm._routePath, "/nowhere") ? Color(hex: specAdd(ThemeManager.shared.resolve("primary"), "22") as? String ?? "transparent") : Color.clear), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
        }
        .buttonStyle(.plain)
      }
      .padding(ThemeManager.shared.size("spacing-3"))
      .background(ThemeManager.shared.color("surface-raised"))
      .frame(width: CGFloat(200))
      .frame(minHeight: CGFloat(300))
      .background(ThemeManager.shared.color("surface-raised"))
      VStack() {
        VStack() {
          if specEq(vm._routePath, "/") {
            RouterHomeView()
          }
        }

        VStack() {
          if specEq(vm._routePath, "/about") {
            RouterAboutView()
          }
        }

        VStack() {
          if ((specNeq(vm._routePath, "/") && specNeq(vm._routePath, "/about")) && specGet(vm._routeParams, "id") != nil) {
            RouterUserView(userId: specGet(vm._routeParams, "id"))
          }
        }

        VStack() {
          if ((specNeq(vm._routePath, "/") && specNeq(vm._routePath, "/about")) && specGet(vm._routeParams, "id") == nil) {
            RouterNotFoundView()
          }
        }

      }
      .background(ThemeManager.shared.color("surface"))
      .background(ThemeManager.shared.color("surface"))
      .frame(maxWidth: .infinity)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
