import SwiftUI
import SpecRuntime

@Observable
final class ListViewModel {
  var height: Any = ""
  var items: Any = [] as [Any]
  var searchable: Any = false
  var searchPlaceholder: Any = "Search..."
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  var selectedIds: Any? = nil as Any? as Any
  var searchQuery: Any = ""
  init() {
    selectedIds = selected
  }
  var filteredItems: Any { (specNeq(searchQuery, "") ? specFilter(items, { (item: Any) -> Bool in return specIncludes((specGet(item, "label") as? String ?? "").lowercased(), (searchQuery as? String ?? "").lowercased()) }) : items) }
  var hasItems: Any { (specDouble(specLength(filteredItems)) > specDouble(0)) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func setSearch(_ v: Any) {
    searchQuery = v
    /* event callback */
  }
  func handleSelect(_ id: Any) {
    if specEq(selection, "single") {
      selectedIds = [id] as [Any]
      /* event callback */
    } else {
      if specEq(selection, "multi") {
        if specIncludes(selectedIds, id) {
          selectedIds = specFilter(selectedIds, { (sid: Any) -> Bool in return specNeq(sid, id) })
        } else {
          selectedIds = specAdd(selectedIds, [id] as [Any])
        }
        /* event callback */
      }
    }
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct ListView: View {
  @State private var vm = ListViewModel()
  var height: Any = ""
  var items: Any = [] as [Any]
  var searchable: Any = false
  var searchPlaceholder: Any = "Search..."
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  init(height: Any = "", items: Any = [] as [Any], searchable: Any = false, searchPlaceholder: Any = "Search...", selected: Any = [] as [Any], selection: Any = "none") { self._vm = State(initialValue: ListViewModel()); self.height = height; self.items = items; self.searchable = searchable; self.searchPlaceholder = searchPlaceholder; self.selected = selected; self.selection = selection }
  var body: some View {
    VStack() {
      VStack() {
        VStack() {
          if (vm.searchable) as? Bool ?? false {
            TextField(specString(vm.searchPlaceholder), text: Binding(get: { vm.searchQuery as? String ?? "" }, set: { vm.searchQuery = $0 }))
              .textFieldStyle(.roundedBorder)
          }
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        ScrollView(.horizontal, showsIndicators: true) {
        VStack() {
          ForEach(Array(specArr(vm.filteredItems).enumerated()), id: \.offset) { _idx, item in
            Button(action: { vm.handleSelect(specGet(item, "id")) }) {
            HStack(alignment: .center) {
              Text(verbatim: specString(specGet(item, "label")))
                .font(.body.bold())
                .foregroundStyle((specIncludes(vm.selectedIds, specGet(item, "id")) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-primary")))
            }
            .padding(ThemeManager.shared.size("spacing-2"))
            .background((specIncludes(vm.selectedIds, specGet(item, "id")) ? ThemeManager.shared.color("surface-raised") : Color.clear))
            .opacity(CGFloat(0))
            .background((specIncludes(vm.selectedIds, specGet(item, "id")) ? ThemeManager.shared.color("surface-raised") : Color.clear))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
          }
        }
        }

        HStack(alignment: .center) {
          if specEq(vm.hasItems, false) {
            Text(verbatim: specString("No items"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
          }
        }
        .padding(ThemeManager.shared.size("spacing-3"))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.searchPlaceholder, searchPlaceholder) { vm.searchPlaceholder = searchPlaceholder }; if !specEq(vm.height, height) { vm.height = height } }
    .task(id: specPropsKey([items, selection, selected, searchable, searchPlaceholder, height])) { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.searchPlaceholder, searchPlaceholder) { vm.searchPlaceholder = searchPlaceholder }; if !specEq(vm.height, height) { vm.height = height } }
  }
}
