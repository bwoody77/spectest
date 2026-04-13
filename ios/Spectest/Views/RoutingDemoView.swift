import SwiftUI
import SpecRuntime

@Observable
final class RoutingDemoViewModel {
  var _routePath: Any? = /* runtime: _getPathname */  Optional<Any>.none as Any
  var _routeParams: Any = [String: Any]()
  func navigate(_ path: Any) {
    /* runtime: navigate */  Optional<Any>.none as Any
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct RoutingDemoView: View {
  @State private var vm = RoutingDemoViewModel()
  var body: some View {
    HStack(alignment: .center, spacing: CGFloat(0)) {
      VStack(spacing: CGFloat(4)) {
        Text(verbatim: specString("Navigation"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
        Button(action: { vm.navigate("/") }) {
        VStack() {
          Text(verbatim: specString("Home"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: (specEq(vm._routePath, "/") ? "#1677ff" : "#202732") as? String ?? "transparent"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: (specEq(vm._routePath, "/") ? specAdd("#1677ff", "22") : "transparent") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
        .buttonStyle(.plain)
        Button(action: { vm.navigate("/about") }) {
        VStack() {
          Text(verbatim: specString("About"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: (specEq(vm._routePath, "/about") ? "#1677ff" : "#202732") as? String ?? "transparent"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: (specEq(vm._routePath, "/about") ? specAdd("#1677ff", "22") : "transparent") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
        .buttonStyle(.plain)
        Text(verbatim: specString("Users"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
        ForEach(Array(specArr([["id": "1" as Any] as [String: Any], ["id": "2" as Any] as [String: Any], ["id": "3" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, user in
          Button(action: { vm.navigate(specAdd("/users/", specGet(user, "id"))) }) {
          VStack() {
            Text(verbatim: specString("User #\(specString(specGet(user, "id")))"))
              .font(.callout.bold())
              .foregroundStyle(Color(hex: (specEq(vm._routePath, specAdd("/users/", specGet(user, "id"))) ? "#1677ff" : "#202732") as? String ?? "transparent"))
          }
          .padding(CGFloat(0))
          .background(Color(hex: (specEq(vm._routePath, specAdd("/users/", specGet(user, "id"))) ? specAdd("#1677ff", "22") : "transparent") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          }
          .buttonStyle(.plain)
        }
        Button(action: { vm.navigate("/nowhere") }) {
        VStack() {
          Text(verbatim: specString("Unknown route →"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: "#dc2626"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: (specEq(vm._routePath, "/nowhere") ? specAdd("#1677ff", "22") : "transparent") as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
        .buttonStyle(.plain)
      }
      .padding(CGFloat(12))
      .background(ThemeManager.shared.color("semantic.on-destructive"))
      .frame(width: CGFloat(200))
      .frame(minHeight: CGFloat(300))
      .background(ThemeManager.shared.color("semantic.on-destructive"))
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
      .background(ThemeManager.shared.color("semantic.surface"))
      .frame(minHeight: CGFloat(0))
      .frame(minWidth: CGFloat(0))
      .background(ThemeManager.shared.color("semantic.surface"))
      .frame(maxWidth: .infinity)
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
  }
}
