import SwiftUI
import SpecRuntime

@Observable
final class RoutingDemoViewModel {
  var _routePath: Any? = /* runtime: _getPathname */  _ = Optional<Any>.none
  var _routeParams: Any = [String: Any]()
  func navigate(_ path: Any) {
    /* runtime: navigate */  _ = Optional<Any>.none
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct RoutingDemoView: View {
  @State private var vm = RoutingDemoViewModel()
  var body: some View {
    HStack(alignment: .center, spacing: CGFloat(0)) {
      VStack(spacing: CGFloat(4)) {
        Text(specString("Navigation"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
        VStack() {
          Text(specString("Home"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((specString(vm._routePath) == specString("/")) ? "#1677ff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((specString(vm._routePath) == specString("/")) ? specAdd("#1677ff", "22") : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.navigate("/") }
        VStack() {
          Text(specString("About"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: ((specString(vm._routePath) == specString("/about")) ? "#1677ff" : "#202732") as? String ?? "#000"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((specString(vm._routePath) == specString("/about")) ? specAdd("#1677ff", "22") : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.navigate("/about") }
        Text(specString("Users"))
          .font(.body.bold())
          .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
        LazyVStack(spacing: CGFloat(8)) {
          ForEach(Array(([["id": "1" as Any] as [String: Any], ["id": "2" as Any] as [String: Any], ["id": "3" as Any] as [String: Any]] as [Any] as? [Any] ?? []).enumerated()), id: \.offset) { _idx, user in
            VStack() {
              Text(specString("User #\(specString((user as? [String: Any])?["id"]))"))
                .font(.callout.bold())
                .foregroundStyle(Color(hex: ((specString(vm._routePath) == specString(specAdd("/users/", (user as? [String: Any])?["id"]))) ? "#1677ff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(0))
            .background(Color(hex: ((specString(vm._routePath) == specString(specAdd("/users/", (user as? [String: Any])?["id"]))) ? specAdd("#1677ff", "22") : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
            .onTapGesture { vm.navigate(specAdd("/users/", (user as? [String: Any])?["id"])) }
          }
        }
        VStack() {
          Text(specString("Unknown route →"))
            .font(.callout.bold())
            .foregroundStyle(Color(hex: "#dc2626"))
        }
        .padding(CGFloat(0))
        .background(Color(hex: ((specString(vm._routePath) == specString("/nowhere")) ? specAdd("#1677ff", "22") : "transparent") as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.navigate("/nowhere") }
      }
      .padding(CGFloat(12))
      .background(ThemeManager.shared.color("semantic.on-destructive"))
      .frame(width: CGFloat(200))
      .frame(minHeight: CGFloat(300))
      .background(ThemeManager.shared.color("semantic.on-destructive"))
      VStack() {
        VStack() {
          if (specString(vm._routePath) == specString("/")) {
            RouterHomeView()
          }
        }

        VStack() {
          if (specString(vm._routePath) == specString("/about")) {
            RouterAboutView()
          }
        }

        VStack() {
          if (((specString(vm._routePath) != specString("/")) && (specString(vm._routePath) != specString("/about"))) && (vm._routeParams as? [String: Any])?["id"] != nil) {
            RouterUserView(userId: (vm._routeParams as? [String: Any])?["id"])
          }
        }

        VStack() {
          if (((specString(vm._routePath) != specString("/")) && (specString(vm._routePath) != specString("/about"))) && (vm._routeParams as? [String: Any])?["id"] == nil) {
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
