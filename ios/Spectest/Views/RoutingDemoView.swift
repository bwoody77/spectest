import SwiftUI
import SpecRuntime

@Observable
final class RoutingDemoViewModel {
  var _routePath: Any = "/"
  var _routeParams: Any = [String: Any]()
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
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
