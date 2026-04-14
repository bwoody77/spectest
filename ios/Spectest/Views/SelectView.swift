import SwiftUI
import SpecRuntime

@Observable
final class SelectViewModel {
  var disabled: Any = false
  var label: Any = ""
  var options: Any = [] as [Any]
  var placeholder: Any = "Select..."
  var searchable: Any = false
  var value: Any = ""
  var open: Any = false
  var query: Any = ""
  var highlightIndex: Any = 0
  var focused: Any = false
  var safeOptions: Any { (options != nil ? options : [] as [Any]) }
  var filteredOptions: Any { (((searchable) as? Bool ?? false && specNeq(query, "")) ? specFilter(safeOptions, { (o: Any) -> Bool in return specIncludes((specGet(o, "label") as? String ?? "").lowercased(), (query as? String ?? "").lowercased()) }) : safeOptions) }
  var selectedOption: Any { specFirst(safeOptions, { (o: Any) -> Bool in return specEq(specGet(o, "value"), value) }) }
  var displayText: Any { (selectedOption != nil ? specGet(selectedOption, "label") : placeholder) }
  var hasOptions: Any { (specDouble(specLength(filteredOptions)) > specDouble(0)) }
  var navSections: Any { [["heading": "Overview" as Any, "items": [["id": "dashboard" as Any, "label": "Dashboard" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "icon": "bar-chart" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Tasks" as Any, "items": [["id": "detail" as Any, "label": "Task Detail" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Data" as Any, "items": [["id": "datagrid" as Any, "label": "Product Catalog" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "icon": "list" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "People" as Any, "items": [["id": "team" as Any, "label": "Team" as Any, "icon": "user" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Monitoring" as Any, "items": [["id": "activity" as Any, "label": "Activity" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "icon": "bell" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Performance" as Any, "items": [["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "icon": "zap" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Marketing" as Any, "items": [["id": "landing2" as Any, "label": "Landing Page" as Any, "icon": "globe" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Design" as Any, "items": [["id": "themepreview" as Any, "label": "Theme Preview" as Any, "icon": "palette" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Components" as Any, "items": [["id": "charts" as Any, "label": "Charts" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "icon": "smartphone" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "Testing" as Any, "items": [["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "icon": "check-circle" as Any] as [String: Any]] as [Any] as Any] as [String: Any], ["heading": "System" as Any, "items": [["id": "settings" as Any, "label": "Settings" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] as Any] as [String: Any]] as [Any] }
  var navItems: Any { [["id": "dashboard" as Any, "label": "Dashboard" as Any, "group": "Overview" as Any, "icon": "home" as Any] as [String: Any], ["id": "analytics" as Any, "label": "Analytics" as Any, "group": "Overview" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "detail" as Any, "label": "Task Detail" as Any, "group": "Tasks" as Any, "icon": "eye" as Any] as [String: Any], ["id": "create" as Any, "label": "Create Task" as Any, "group": "Tasks" as Any, "icon": "plus" as Any] as [String: Any], ["id": "wizard" as Any, "label": "Task Wizard" as Any, "group": "Tasks" as Any, "icon": "list" as Any] as [String: Any], ["id": "datagrid" as Any, "label": "Product Catalog" as Any, "group": "Data" as Any, "icon": "layout" as Any] as [String: Any], ["id": "editgrid" as Any, "label": "Editable Grid" as Any, "group": "Data" as Any, "icon": "edit" as Any] as [String: Any], ["id": "categories" as Any, "label": "Categories" as Any, "group": "Data" as Any, "icon": "list" as Any] as [String: Any], ["id": "team" as Any, "label": "Team" as Any, "group": "People" as Any, "icon": "user" as Any] as [String: Any], ["id": "activity" as Any, "label": "Activity" as Any, "group": "Monitoring" as Any, "icon": "clock" as Any] as [String: Any], ["id": "notifications" as Any, "label": "Notifications" as Any, "group": "Monitoring" as Any, "icon": "bell" as Any] as [String: Any], ["id": "perfgrid" as Any, "label": "Grid 10K" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "perfsignals" as Any, "label": "Signal Test" as Any, "group": "Performance" as Any, "icon": "activity" as Any] as [String: Any], ["id": "reactivityperf" as Any, "label": "Reactivity Perf" as Any, "group": "Performance" as Any, "icon": "zap" as Any] as [String: Any], ["id": "landing2" as Any, "label": "Landing Page" as Any, "group": "Marketing" as Any, "icon": "globe" as Any] as [String: Any], ["id": "themepreview" as Any, "label": "Theme Preview" as Any, "group": "Design" as Any, "icon": "palette" as Any] as [String: Any], ["id": "charts" as Any, "label": "Charts" as Any, "group": "Components" as Any, "icon": "bar-chart" as Any] as [String: Any], ["id": "drag" as Any, "label": "Drag & Drop" as Any, "group": "Components" as Any, "icon": "layout" as Any] as [String: Any], ["id": "formdemo" as Any, "label": "Form Validation" as Any, "group": "Components" as Any, "icon": "edit" as Any] as [String: Any], ["id": "routing" as Any, "label": "Routing" as Any, "group": "Components" as Any, "icon": "globe" as Any] as [String: Any], ["id": "mobiledemo" as Any, "label": "Mobile Demo" as Any, "group": "Components" as Any, "icon": "smartphone" as Any] as [String: Any], ["id": "featuretest" as Any, "label": "Feature Test (P1-P8)" as Any, "group": "Testing" as Any, "icon": "check-circle" as Any] as [String: Any], ["id": "settings" as Any, "label": "Settings" as Any, "group": "System" as Any, "icon": "settings" as Any] as [String: Any]] as [Any] }
  func toggleOpen() {
    if specEq(disabled, false) {
      open = specEq(open, false)
      query = ""
      highlightIndex = 0
    }
  }
  func openDropdown() {
    if (specEq(disabled, false) && specEq(open, false)) {
      open = true
      query = ""
      highlightIndex = 0
    }
  }
  func closeDropdown() {
    open = false
    query = ""
  }
  func selectOption(_ val: Any) {
    /* event callback */
    open = false
    query = ""
  }
  func setQuery(_ v: Any) {
    query = v
    highlightIndex = 0
  }
  func moveHighlight(_ delta: Any) {
    if (specDouble(specLength(filteredOptions)) > specDouble(0)) {
      highlightIndex = wrapIndex(highlightIndex, delta, specLength(filteredOptions))
    }
  }
  func selectHighlighted() {
    if ((specDouble(specLength(filteredOptions)) > specDouble(0)) && (specDouble(highlightIndex) < specDouble(specLength(filteredOptions)))) {
      selectOption(specGet(specGet(filteredOptions, highlightIndex), "value"))
    }
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct SelectView: View {
  @State private var vm = SelectViewModel()
  var disabled: Any = false
  var label: Any = ""
  var options: Any = [] as [Any]
  var placeholder: Any = "Select..."
  var searchable: Any = false
  var value: Any = ""
  init(disabled: Any = false, label: Any = "", options: Any = [] as [Any], placeholder: Any = "Select...", searchable: Any = false, value: Any = "") { self._vm = State(initialValue: SelectViewModel()); self.disabled = disabled; self.label = label; self.options = options; self.placeholder = placeholder; self.searchable = searchable; self.value = value }
  var body: some View {
    VStack() {
      VStack(spacing: ThemeManager.shared.size("spacing-1")) {
        VStack() {
          if specNeq(vm.label, "") {
            Text(verbatim: specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
        }

        Button(action: { vm.toggleOpen() }) {
        HStack(alignment: .center) {
          Text(verbatim: specString(vm.displayText))
            .font(.body.bold())
            .foregroundStyle((vm.selectedOption != nil ? ThemeManager.shared.color("text-primary") : ThemeManager.shared.color("text-tertiary")))
          Text(verbatim: specString("u25BE"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
        }
        .padding(ThemeManager.shared.size("spacing-2"))
        .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.5 : 1)))
        .frame(minHeight: CGFloat(40))
        .background(ThemeManager.shared.color("select-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("select-radius")))
        .hoverEffect(.highlight)
        .focusable()
        .onKeyPress(.escape) { Task { @MainActor in await vm.closeDropdown() }; return .handled }
        .onKeyPress(.tab) { Task { @MainActor in await vm.closeDropdown() }; return .handled }
        }
        .buttonStyle(.plain)
        Color.clear.frame(width: 0, height: 0)
          .overlay {
            if (vm.open) as? Bool ?? false {
              ZStack {
                Color.clear.ignoresSafeArea()
                  .onTapGesture {
                    vm.closeDropdown()
                  }
                ScrollView(.horizontal, showsIndicators: true) {
                VStack() {
                  VStack() {
                    if (vm.searchable) as? Bool ?? false {
                      TextField(specString("Search..."), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
                        .textFieldStyle(.roundedBorder)
                    }
                  }
                  .padding(ThemeManager.shared.size("spacing-2"))
                  VStack() {
                    if (vm.hasOptions) as? Bool ?? false {
                      ForEach(Array(specArr(vm.filteredOptions).enumerated()), id: \.offset) { idx, option in
                        Button(action: { vm.selectOption(specGet(option, "value")) }) {
                        VStack() {
                          Text(verbatim: specString(specGet(option, "label")))
                            .font(.body.bold())
                            .foregroundStyle((specEq(specGet(option, "value"), vm.value) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-primary")))
                        }
                        .padding(ThemeManager.shared.size("spacing-2"))
                        .background(({ () -> Color in switch specString(specEq(idx, vm.highlightIndex)) {
case specString(true): return ThemeManager.shared.color("select-optionHover")
default: return ({ () -> Color in switch specString(specEq(specGet(option, "value"), vm.value)) {
case specString(true): return ThemeManager.shared.color("select-optionSelected")
default: return Color.clear
} })()
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
                        .hoverEffect(.highlight)
                        }
                        .buttonStyle(.plain)
                      }
                    }
                  }

                  HStack(alignment: .center) {
                    if specEq(vm.hasOptions, false) {
                      Text(verbatim: specString("No options"))
                        .font(.body.bold())
                        .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                    }
                  }
                  .padding(ThemeManager.shared.size("spacing-3"))
                }
                }
                .padding(ThemeManager.shared.size("spacing-1"))
                .frame(maxHeight: CGFloat(240))
                .background(ThemeManager.shared.color("select-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("select-radius")))
              }
            }
          }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.label, label) { vm.label = label } }
    .task(id: specPropsKey([options, value, placeholder, searchable, disabled, label])) { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.label, label) { vm.label = label } }
  }
}
