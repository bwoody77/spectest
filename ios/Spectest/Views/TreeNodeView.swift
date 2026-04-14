import SwiftUI
import SpecRuntime

@Observable
final class TreeNodeViewModel {
  var expandedIds: Any = [] as [Any]
  var expandMode: Any = "icon"
  var level: Any = 1
  var node: Any? = nil
  var selectedIds: Any = [] as [Any]
  var selectionMode: Any = "none"
  var isExpanded: Any { specIncludes(expandedIds, specGet(node, "id")) }
  var isSelected: Any { specIncludes(selectedIds, specGet(node, "id")) }
  var hasChildren: Any { (specGet(node, "children") != nil && (specDouble(specLength(specGet(node, "children"))) > specDouble(0))) }
  var toggleIcon: Any { ((isExpanded) as? Bool ?? false ? "▾" : "▸") }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func handleToggle() {
    if specEq(expandMode, "icon") {
      /* event callback */
    }
  }
  func handleSelect() {
    if (specNeq(specGet(node, "disabled"), true) && specNeq(selectionMode, "none")) {
      /* event callback */
    }
  }
  func handleRowClick() {
    if specEq(expandMode, "row") {
      if (hasChildren) as? Bool ?? false {
        /* event callback */
      } else {
        handleSelect()
      }
    } else {
      handleSelect()
    }
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct TreeNodeView: View {
  @State private var vm = TreeNodeViewModel()
  var expandedIds: Any = [] as [Any]
  var expandMode: Any = "icon"
  var level: Any = 1
  var node: Any? = nil
  var selectedIds: Any = [] as [Any]
  var selectionMode: Any = "none"
  init(expandedIds: Any = [] as [Any], expandMode: Any = "icon", level: Any = 1, node: Any? = nil, selectedIds: Any = [] as [Any], selectionMode: Any = "none") { self._vm = State(initialValue: TreeNodeViewModel()); self.expandedIds = expandedIds; self.expandMode = expandMode; self.level = level; self.node = node; self.selectedIds = selectedIds; self.selectionMode = selectionMode }
  var body: some View {
    VStack() {
      VStack() {
        Button(action: { vm.handleRowClick() }) {
        HStack(alignment: .center) {
          Button(action: { vm.handleToggle() }) {
          VStack() {
            if (vm.hasChildren) as? Bool ?? false {
              Text(verbatim: specString(vm.toggleIcon))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          }
          .buttonStyle(.plain)
          VStack() {
            if specEq(vm.hasChildren, false) {
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          HStack(alignment: .center) {
            if specGet(vm.node, "icon") != nil {
              Image(systemName: specIconName(specString((specGet(vm.node, "icon") != nil ? specGet(vm.node, "icon") : ""))))
                .font(.system(size: specPx(16)))
                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          Text(verbatim: specString(specGet(vm.node, "label")))
            .font(.body.bold())
            .foregroundStyle(((vm.isSelected) as? Bool ?? false ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-primary")))
        }
        .padding(.top, ThemeManager.shared.size("spacing-1"))
        .padding(.bottom, ThemeManager.shared.size("spacing-1"))
        .opacity(specPx((specEq(specGet(vm.node, "disabled"), true) ? 0.5 : 1)))
        .hoverEffect(.highlight)
        }
        .buttonStyle(.plain)
        VStack() {
          if ((vm.isExpanded) as? Bool ?? false && (vm.hasChildren) as? Bool ?? false) {
            ForEach(Array(specArr(specGet(vm.node, "children")).enumerated()), id: \.offset) { _idx, child in
              TreeNodeView(expandedIds: vm.expandedIds, expandMode: vm.expandMode, level: specAdd(vm.level, 1), node: child, selectedIds: vm.selectedIds, selectionMode: vm.selectionMode)
            }
          }
        }
        .padding(.leading, CGFloat(20))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.node, node) { vm.node = node }; if !specEq(vm.level, level) { vm.level = level }; if !specEq(vm.expandedIds, expandedIds) { vm.expandedIds = expandedIds }; if !specEq(vm.selectedIds, selectedIds) { vm.selectedIds = selectedIds }; if !specEq(vm.selectionMode, selectionMode) { vm.selectionMode = selectionMode }; if !specEq(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
    .task(id: specPropsKey([node, level, expandedIds, selectedIds, selectionMode, expandMode])) { if !specEq(vm.node, node) { vm.node = node }; if !specEq(vm.level, level) { vm.level = level }; if !specEq(vm.expandedIds, expandedIds) { vm.expandedIds = expandedIds }; if !specEq(vm.selectedIds, selectedIds) { vm.selectedIds = selectedIds }; if !specEq(vm.selectionMode, selectionMode) { vm.selectionMode = selectionMode }; if !specEq(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
  }
}
