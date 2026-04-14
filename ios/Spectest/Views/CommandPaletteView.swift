import SwiftUI
import SpecRuntime

@Observable
final class CommandPaletteViewModel {
  var commands: Any = [] as [Any]
  var maxResults: Any = 50
  var open: Any = false
  var placeholder: Any = "Type a command..."
  var query: Any = ""
  var highlightIndex: Any = 0
  var filtered: Any { (specNeq(query, "") ? specFilter(commands, { (c: Any) -> Bool in return specIncludes((specGet(c, "label") as? String ?? "").lowercased(), (query as? String ?? "").lowercased()) }) : commands) }
  var results: Any { ((specDouble(specLength(filtered)) > specDouble(maxResults)) ? specSlice(filtered, 0, maxResults) : filtered) }
  var hasResults: Any { (specDouble(specLength(results)) > specDouble(0)) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func setQuery(_ v: Any) {
    query = v
    highlightIndex = 0
  }
  func selectItem(_ id: Any) {
    /* event callback */
    query = ""
    highlightIndex = 0
  }
  func dismiss() {
    /* event callback */
    query = ""
    highlightIndex = 0
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct CommandPaletteView: View {
  @State private var vm = CommandPaletteViewModel()
  var commands: Any = [] as [Any]
  var maxResults: Any = 50
  var open: Any = false
  var placeholder: Any = "Type a command..."
  init(commands: Any = [] as [Any], maxResults: Any = 50, open: Any = false, placeholder: Any = "Type a command...") { self._vm = State(initialValue: CommandPaletteViewModel()); self.commands = commands; self.maxResults = maxResults; self.open = open; self.placeholder = placeholder }
  var body: some View {
    VStack() {
      Color.clear.frame(width: 0, height: 0)
        .overlay {
          if (vm.open) as? Bool ?? false {
            ZStack {
              Color.black.opacity(0.15).ignoresSafeArea()
                .onTapGesture {
                  vm.dismiss()
                }
              VStack() {
                VStack() {
                  TextField(specString(vm.placeholder), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
                    .textFieldStyle(.roundedBorder)
                }
                .padding(ThemeManager.shared.size("spacing-3"))
                ScrollView(.horizontal, showsIndicators: true) {
                VStack() {
                  VStack() {
                    if (vm.hasResults) as? Bool ?? false {
                      ForEach(Array(specArr(vm.results).enumerated()), id: \.offset) { idx, cmd in
                        Button(action: { vm.selectItem(specGet(cmd, "id")) }) {
                        HStack(alignment: .center) {
                          VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                            Text(verbatim: specString(specGet(cmd, "label")))
                              .font(.body.bold())
                              .foregroundStyle(ThemeManager.shared.color("text-primary"))
                            VStack() {
                              if specGet(cmd, "description") != nil {
                                Text(verbatim: specString(specGet(cmd, "description")))
                                  .font(.body.bold())
                                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                              }
                            }

                          }

                          VStack() {
                            if specGet(cmd, "shortcut") != nil {
                              Text(verbatim: specString(specGet(cmd, "shortcut")))
                                .font(.body.bold())
                                .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                            }
                          }
                          .padding(ThemeManager.shared.size("spacing-1"))
                          .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
                        }
                        .padding(ThemeManager.shared.size("spacing-3"))
                        .background((specEq(idx, vm.highlightIndex) ? ThemeManager.shared.color("surface-raised") : Color.clear))
                        .background((specEq(idx, vm.highlightIndex) ? ThemeManager.shared.color("surface-raised") : Color.clear))
                        .hoverEffect(.highlight)
                        }
                        .buttonStyle(.plain)
                      }
                    }
                  }

                  HStack(alignment: .center) {
                    if (specEq(vm.hasResults, false) && specNeq(vm.query, "")) {
                      Text(verbatim: specString("No matching commands"))
                        .font(.body.bold())
                        .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                    }
                  }
                  .padding(ThemeManager.shared.size("spacing-4"))
                }
                }
                .frame(maxHeight: CGFloat(360))
              }
              .frame(width: CGFloat(560))
              .frame(maxWidth: CGFloat(0))
              .frame(maxHeight: CGFloat(480))
              .background(ThemeManager.shared.color("surface"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("lg")))
            }
          }
        }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.commands, commands) { vm.commands = commands }; if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.maxResults, maxResults) { vm.maxResults = maxResults } }
    .task(id: specPropsKey([commands, open, placeholder, maxResults])) { if !specEq(vm.commands, commands) { vm.commands = commands }; if !specEq(vm.open, open) { vm.open = open }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.maxResults, maxResults) { vm.maxResults = maxResults } }
  }
}
