import SwiftUI
import SpecRuntime

@Observable
final class SidebarViewModel {
  var activeItem: Any = ""
  var collapsed: Any = false
  var collapsedWidth: Any = "56px"
  var sections: Any? = nil
  var width: Any = "240px"
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct SidebarView: View {
  @State private var vm = SidebarViewModel()
  var activeItem: Any = ""
  var collapsed: Any = false
  var collapsedWidth: Any = "56px"
  var sections: Any? = nil
  var width: Any = "240px"
  init(activeItem: Any = "", collapsed: Any = false, collapsedWidth: Any = "56px", sections: Any? = nil, width: Any = "240px") { self._vm = State(initialValue: SidebarViewModel()); self.activeItem = activeItem; self.collapsed = collapsed; self.collapsedWidth = collapsedWidth; self.sections = sections; self.width = width }
  var body: some View {
    VStack() {
      VStack() {
        HStack(alignment: .center) {
          if specEq(vm.collapsed, true) {
            Button(action: { /* event callback */ }) {
            HStack(alignment: .center) {
              Text(verbatim: specString("u00BB"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .frame(width: CGFloat(32))
            .specFrameHeight(CGFloat(32))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
          }
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        HStack(alignment: .center) {
          if specEq(vm.collapsed, false) {
            Button(action: { /* event callback */ }) {
            HStack(alignment: .center) {
              Text(verbatim: specString("u00AB"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .frame(width: CGFloat(32))
            .specFrameHeight(CGFloat(32))
            .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
          }
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        ScrollView(.horizontal, showsIndicators: true) {
        VStack(spacing: ThemeManager.shared.size("spacing-1")) {
          ForEach(Array(specArr(vm.sections).enumerated()), id: \.offset) { _idx, section in
            VStack() {
              if (specEq(vm.collapsed, false) && specGet(section, "title") != nil) {
                Text(verbatim: specString(specGet(section, "title")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
              }
            }
            .padding(ThemeManager.shared.size("spacing-2"))
            .opacity(specPx((specEq(vm.collapsed, false) ? 1 : 0)))
            ForEach(Array(specArr(specGet(section, "items")).enumerated()), id: \.offset) { _idx, item in
              Button(action: { /* event callback */ }) {
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                HStack(alignment: .center) {
                  Image(systemName: specIconName(specString((specGet(item, "icon") != nil ? specGet(item, "icon") : "circle"))))
                    .font(.system(size: specPx(18)))
                    .foregroundStyle((specEq(specGet(item, "id"), vm.activeItem) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-secondary")))
                }
                .frame(width: CGFloat(24))
                .specFrameHeight(CGFloat(24))
                .frame(minWidth: CGFloat(24))
                VStack() {
                  if specEq(vm.collapsed, false) {
                    Text(verbatim: specString(specGet(item, "label")))
                      .font(.body.bold())
                      .foregroundStyle((specEq(specGet(item, "id"), vm.activeItem) ? ThemeManager.shared.color("text-primary") : ThemeManager.shared.color("text-secondary")))
                  }
                }
                .opacity(specPx((specEq(vm.collapsed, false) ? 1 : 0)))
              }
              .padding(ThemeManager.shared.size("spacing-2"))
              .background((specEq(specGet(item, "id"), vm.activeItem) ? ThemeManager.shared.color("surface-raised") : Color.clear), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-md")))
              .hoverEffect(.highlight)
              }
              .buttonStyle(.plain)
            }
          }
        }
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        .frame(maxWidth: .infinity)
      }
      .background(ThemeManager.shared.color("surface"))
      .frame(width: specPx(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)))
      .frame(maxHeight: .infinity)
      .frame(minWidth: specPx(((vm.collapsed) as? Bool ?? false ? vm.collapsedWidth : vm.width)))
      .background(ThemeManager.shared.color("surface"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.sections, sections) { vm.sections = sections }; if !specEq(vm.activeItem, activeItem) { vm.activeItem = activeItem }; if !specEq(vm.collapsed, collapsed) { vm.collapsed = collapsed }; if !specEq(vm.width, width) { vm.width = width }; if !specEq(vm.collapsedWidth, collapsedWidth) { vm.collapsedWidth = collapsedWidth } }
    .task(id: specPropsKey([sections, activeItem, collapsed, width, collapsedWidth])) { if !specEq(vm.sections, sections) { vm.sections = sections }; if !specEq(vm.activeItem, activeItem) { vm.activeItem = activeItem }; if !specEq(vm.collapsed, collapsed) { vm.collapsed = collapsed }; if !specEq(vm.width, width) { vm.width = width }; if !specEq(vm.collapsedWidth, collapsedWidth) { vm.collapsedWidth = collapsedWidth } }
  }
}
