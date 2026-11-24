import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class RoutingDemoViewModel {
  var _routePath: Any { get { SpecRouteStore.shared.path } set { SpecRouteStore.shared.path = newValue } }
  var _routeParams: Any { get { SpecRouteStore.shared.params } set { SpecRouteStore.shared.params = newValue } }
  var _routeQuery: Any { get { SpecRouteStore.shared.query } set { SpecRouteStore.shared.query = newValue } }
  init() {
    SpecRouteStore.shared.routes = [("^\\/$", []), ("^\\/about$", []), ("^\\/users\\/([^/]+)$", ["id"])]
  }
  func navigate(_ path: Any) {
    specNavigate(path, [("^\\/$", []), ("^\\/about$", []), ("^\\/users\\/([^/]+)$", ["id"])])
  }
  func navigateReplace(_ path: Any) {
    specNavigate(path, [("^\\/$", []), ("^\\/about$", []), ("^\\/users\\/([^/]+)$", ["id"])], replace: true)
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct RoutingDemoView: View {
  @State private var vm = RoutingDemoViewModel()
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = RoutingDemoViewModel(); _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.onDispatch = onDispatch }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    HStack(alignment: .center, spacing: CGFloat(0)) {
      VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
        Text(verbatim: specString("Navigation"))
          .font(.footnote)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
        Button(action: { specClick { vm.navigate("/") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("Home"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle((specEq(vm._routePath, "/") ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("text-primary")))
        }
        .padding(.leading, specBorderWidth((specEq(vm._routePath, "/") ? specAdd("3px solid ", ThemeManager.shared.rawToken("primary")) : "3px solid transparent")))
        .padding(.vertical, CGFloat(8))
        .padding(.horizontal, CGFloat(12))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background((specEq(vm._routePath, "/") ? Color(hex: specAdd(ThemeManager.shared.rawToken("primary"), "22") as? String ?? "transparent") : Color.clear), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: (specEq(vm._routePath, "/") ? specAdd("3px solid ", ThemeManager.shared.rawToken("primary")) : "3px solid transparent"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Button(action: { specClick { vm.navigate("/about") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("About"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle((specEq(vm._routePath, "/about") ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("text-primary")))
        }
        .padding(.leading, specBorderWidth((specEq(vm._routePath, "/about") ? specAdd("3px solid ", ThemeManager.shared.rawToken("primary")) : "3px solid transparent")))
        .padding(.vertical, CGFloat(8))
        .padding(.horizontal, CGFloat(12))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background((specEq(vm._routePath, "/about") ? Color(hex: specAdd(ThemeManager.shared.rawToken("primary"), "22") as? String ?? "transparent") : Color.clear), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: (specEq(vm._routePath, "/about") ? specAdd("3px solid ", ThemeManager.shared.rawToken("primary")) : "3px solid transparent"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        Text(verbatim: specString("Users"))
          .font(.footnote)
          .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
          .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
        ForEach(Array(specArr([["id": "1" as Any] as [String: Any], ["id": "2" as Any] as [String: Any], ["id": "3" as Any] as [String: Any]] as [Any]).enumerated()), id: \.offset) { _idx, user in
          Button(action: { specClick { vm.navigate(specAdd("/users/", specGet(user, "id"))) } }) {
          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString("User #\(specString(specGet(user, "id")))"))
              .font(.footnote)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
              .foregroundStyle((specEq(vm._routePath, specAdd("/users/", specGet(user, "id"))) ? ThemeManager.shared.color("primary") : ThemeManager.shared.color("text-primary")))
          }
          .padding(.leading, specBorderWidth((specEq(vm._routePath, specAdd("/users/", specGet(user, "id"))) ? specAdd("3px solid ", ThemeManager.shared.rawToken("primary")) : "3px solid transparent")))
          .padding(.vertical, CGFloat(8))
          .padding(.horizontal, CGFloat(12))
          .frame(maxWidth: .infinity, alignment: .leading)
          .background((specEq(vm._routePath, specAdd("/users/", specGet(user, "id"))) ? Color(hex: specAdd(ThemeManager.shared.rawToken("primary"), "22") as? String ?? "transparent") : Color.clear), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .specBorderSides(nil, top: nil, right: nil, bottom: nil, left: (specEq(vm._routePath, specAdd("/users/", specGet(user, "id"))) ? specAdd("3px solid ", ThemeManager.shared.rawToken("primary")) : "3px solid transparent"), radius: specPx(ThemeManager.shared.rawToken("radius-md")))
            .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
        }
        Button(action: { specClick { vm.navigate("/nowhere") } }) {
        VStack(alignment: .leading, spacing: 0) {
          Text(verbatim: specString("Unknown route →"))
            .font(.footnote)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-sm-fontWeight")))
            .foregroundStyle(Color(hex: "#dc2626"))
        }
        .padding(.vertical, CGFloat(8))
        .padding(.horizontal, CGFloat(12))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background((specEq(vm._routePath, "/nowhere") ? Color(hex: specAdd(ThemeManager.shared.rawToken("primary"), "22") as? String ?? "transparent") : Color.clear), in: RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
        .clipShape(RoundedRectangle(cornerRadius: specPx(ThemeManager.shared.rawToken("radius-md"))))
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }
      .padding(specBorderWidth("1px solid #e5e7eb 1px 0 0 0"))
      .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
      .frame(width: CGFloat(200), alignment: .leading)
      .frame(minHeight: CGFloat(300), alignment: .top)
      .background(ThemeManager.shared.color("surface-raised"))
      .specBorderAll("1px solid #e5e7eb 1px 0 0 0", radius: CGFloat(0))
      VStack(alignment: .leading, spacing: 0) {
        if specEq(vm._routePath, "/") {
        VStack(alignment: .leading, spacing: 0) {
          if specEq(vm._routePath, "/") {
            RouterHomeView()
          }
        }

        }
        if specEq(vm._routePath, "/about") {
        VStack(alignment: .leading, spacing: 0) {
          if specEq(vm._routePath, "/about") {
            RouterAboutView()
          }
        }

        }
        if ((specNeq(vm._routePath, "/") && specNeq(vm._routePath, "/about")) && !specIsNil(specGet(vm._routeParams, "id"))) {
        VStack(alignment: .leading, spacing: 0) {
          if ((specNeq(vm._routePath, "/") && specNeq(vm._routePath, "/about")) && !specIsNil(specGet(vm._routeParams, "id"))) {
            RouterUserView(userId: specGet(vm._routeParams, "id"))
          }
        }

        }
        if ((specNeq(vm._routePath, "/") && specNeq(vm._routePath, "/about")) && (specIsNil(specGet(vm._routeParams, "id"))) as? Bool ?? false) {
        VStack(alignment: .leading, spacing: 0) {
          if ((specNeq(vm._routePath, "/") && specNeq(vm._routePath, "/about")) && (specIsNil(specGet(vm._routeParams, "id"))) as? Bool ?? false) {
            RouterNotFoundView()
          }
        }

        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(ThemeManager.shared.color("surface"))
      .specFlexGrow(1)
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
  }
}
