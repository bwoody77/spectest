import SwiftUI
import SpecRuntime

@Observable
final class MultiSelectViewModel {
  var disabled: Any = false
  var display: Any = "chips"
  var label: Any = ""
  var mode: Any = "dropdown"
  var options: Any = [] as [Any]
  var placeholder: Any = "Select..."
  var searchable: Any = true
  var showCheckbox: Any = true
  var values: Any = [] as [Any]
  var open: Any = false
  var query: Any = ""
  var selected: Any? = nil as Any? as Any
  var highlightIndex: Any = 0
  var focused: Any = false
  init() {
    selected = values
  }
  var safeOptions: Any { (options != nil ? options : [] as [Any]) }
  var safeSelected: Any { (selected != nil ? selected : [] as [Any]) }
  var filteredOptions: Any { (((searchable) as? Bool ?? false && specNeq(query, "")) ? specFilter(safeOptions, { (o: Any) -> Bool in return specIncludes((specGet(o, "label") as? String ?? "").lowercased(), (query as? String ?? "").lowercased()) }) : safeOptions) }
  var selectedOptions: Any { specFilter(safeOptions, { (o: Any) -> Bool in return specIncludes(safeSelected, specGet(o, "value")) }) }
  var hasSelections: Any { (specDouble(specLength(safeSelected)) > specDouble(0)) }
  var hasOptions: Any { (specDouble(specLength(filteredOptions)) > specDouble(0)) }
  var displayPlaceholder: Any { (specEq(hasSelections, false) ? placeholder : "") }
  var displayText: Any { (specMap(selectedOptions, { (o: Any) -> Any in return specGet(o, "label") }) as? [Any] ?? []).map { String(describing: $0) }.joined(separator: ", " as? String ?? "") }
  var isDropdownMode: Any { specEq(mode, "dropdown") }
  var showList: Any { (specEq(isDropdownMode, false) || specEq(open, true)) }
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
  func setQuery(_ v: Any) {
    query = v
    highlightIndex = 0
    if specEq(open, false) {
      open = true
    }
  }
  func toggleOption(_ val: Any) {
    if specIncludes(selected, val) {
      selected = specFilter(selected, { (v: Any) -> Bool in return specNeq(v, val) })
    } else {
      selected = specConcat(selected, [val] as [Any])
    }
    /* event callback */
  }
  func removeTag(_ val: Any) {
    selected = specFilter(selected, { (v: Any) -> Bool in return specNeq(v, val) })
    /* event callback */
  }
  func selectAll() {
    selected = specMap(specFilter(filteredOptions, { (o: Any) -> Bool in return specNeq(specGet(o, "disabled"), true) }), { (o: Any) -> Any in return specGet(o, "value") })
    /* event callback */
  }
  func clearAll() {
    selected = [] as [Any]
    /* event callback */
  }
  func moveHighlight(_ delta: Any) {
    if (specDouble(specLength(filteredOptions)) > specDouble(0)) {
      highlightIndex = wrapIndex(highlightIndex, delta, specLength(filteredOptions))
    }
  }
  func toggleHighlighted() {
    if ((specDouble(specLength(filteredOptions)) > specDouble(0)) && (specDouble(highlightIndex) < specDouble(specLength(filteredOptions)))) {
      toggleOption(specGet(specGet(filteredOptions, highlightIndex), "value"))
    }
  }
  func removeLastTag() {
    if (specDouble(specLength(safeSelected)) > specDouble(0)) {
      selected = specSlice(selected, 0, (specDouble(specLength(selected)) - specDouble(1)))
      /* event callback */
    }
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct MultiSelectView: View {
  @State private var vm = MultiSelectViewModel()
  var disabled: Any = false
  var display: Any = "chips"
  var label: Any = ""
  var mode: Any = "dropdown"
  var options: Any = [] as [Any]
  var placeholder: Any = "Select..."
  var searchable: Any = true
  var showCheckbox: Any = true
  var values: Any = [] as [Any]
  init(disabled: Any = false, display: Any = "chips", label: Any = "", mode: Any = "dropdown", options: Any = [] as [Any], placeholder: Any = "Select...", searchable: Any = true, showCheckbox: Any = true, values: Any = [] as [Any]) { self._vm = State(initialValue: MultiSelectViewModel()); self.disabled = disabled; self.display = display; self.label = label; self.mode = mode; self.options = options; self.placeholder = placeholder; self.searchable = searchable; self.showCheckbox = showCheckbox; self.values = values }
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

        VStack(spacing: ThemeManager.shared.size("spacing-1")) {
          if (vm.isDropdownMode) as? Bool ?? false {
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
              HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
                if ((vm.hasSelections) as? Bool ?? false && specEq(vm.display, "chips")) {
                  ForEach(Array(specArr(vm.selectedOptions).enumerated()), id: \.offset) { _idx, opt in
                    HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-1")) {
                      Text(verbatim: specString(specGet(opt, "label")))
                        .font(.body.bold())
                        .foregroundStyle(ThemeManager.shared.color("text-primary"))
                      Button(action: { vm.removeTag(specGet(opt, "value")) }) {
                      VStack() {
                        Text(verbatim: specString("u00D7"))
                          .font(.body.bold())
                          .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                      }

                      }
                      .buttonStyle(.plain)
                    }
                    .padding(.leading, ThemeManager.shared.size("spacing-2"))
                    .padding(.trailing, ThemeManager.shared.size("spacing-1"))
                    .background(ThemeManager.shared.color("surface-raised"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("radius-sm")))
                  }
                }
              }

              VStack() {
                if ((vm.hasSelections) as? Bool ?? false && specEq(vm.display, "text")) {
                  Text(verbatim: specString(vm.displayText))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-primary"))
                }
              }

              Button(action: { vm.toggleOpen() }) {
              HStack(alignment: .center) {
                VStack() {
                  if specEq(vm.hasSelections, false) {
                    Text(verbatim: specString(vm.placeholder))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  }
                }

                Text(verbatim: specString("u25BE"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
              }
              .frame(maxWidth: .infinity)
              }
              .buttonStyle(.plain)
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
                    HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                      Button(action: { vm.selectAll() }) {
                      VStack() {
                        Text(verbatim: specString("Select all"))
                          .font(.body.bold())
                          .foregroundStyle(ThemeManager.shared.color("interactive"))
                      }

                      }
                      .buttonStyle(.plain)
                      Button(action: { vm.clearAll() }) {
                      VStack() {
                        Text(verbatim: specString("Clear all"))
                          .font(.body.bold())
                          .foregroundStyle(ThemeManager.shared.color("interactive"))
                      }

                      }
                      .buttonStyle(.plain)
                    }
                    .padding(ThemeManager.shared.size("spacing-2"))
                    VStack() {
                      if (vm.hasOptions) as? Bool ?? false {
                        ForEach(Array(specArr(vm.filteredOptions).enumerated()), id: \.offset) { idx, option in
                          Button(action: { vm.toggleOption(specGet(option, "value")) }) {
                          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                            Text(verbatim: specString(({ () -> Any in switch specString(vm.showCheckbox) {
case specString(true): return (specIncludes(vm.safeSelected, specGet(option, "value")) ? "u2611" : "u2610")
default: return (specIncludes(vm.safeSelected, specGet(option, "value")) ? "u2713" : "")
} })()))
                              .font(.body.bold())
                              .foregroundStyle(ThemeManager.shared.color("interactive"))
                            Text(verbatim: specString(specGet(option, "label")))
                              .font(.body.bold())
                              .foregroundStyle((specIncludes(vm.safeSelected, specGet(option, "value")) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-primary")))
                          }
                          .padding(ThemeManager.shared.size("spacing-2"))
                          .opacity(CGFloat(0))
                          .background(({ () -> Color in switch specString(specEq(idx, vm.highlightIndex)) {
case specString(true): return ThemeManager.shared.color("select-optionHover")
default: return ({ () -> Color in switch specString(specIncludes(vm.safeSelected, specGet(option, "value"))) {
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
                  .frame(maxHeight: CGFloat(280))
                  .background(ThemeManager.shared.color("select-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("select-radius")))
                }
              }
            }
        }

        VStack(spacing: ThemeManager.shared.size("spacing-1")) {
          if specEq(vm.isDropdownMode, false) {
            VStack() {
              if (vm.hasSelections) as? Bool ?? false {
                Text(verbatim: specString(specAdd(specLength(vm.safeSelected), " selected")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
            }
            .padding(ThemeManager.shared.size("spacing-2"))
          }
          VStack() {
            if (vm.searchable) as? Bool ?? false {
              TextField(specString("Search..."), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
                .textFieldStyle(.roundedBorder)
            }
          }
          .padding(ThemeManager.shared.size("spacing-2"))
          HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
            Button(action: { vm.selectAll() }) {
            VStack() {
              Text(verbatim: specString("Select all"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("interactive"))
            }

            }
            .buttonStyle(.plain)
            Button(action: { vm.clearAll() }) {
            VStack() {
              Text(verbatim: specString("Clear all"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("interactive"))
            }

            }
            .buttonStyle(.plain)
          }
          .padding(ThemeManager.shared.size("spacing-2"))
          ScrollView(.horizontal, showsIndicators: true) {
          VStack() {
            if (vm.hasOptions) as? Bool ?? false {
              ForEach(Array(specArr(vm.filteredOptions).enumerated()), id: \.offset) { idx, option in
                Button(action: { vm.toggleOption(specGet(option, "value")) }) {
                HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
                  Text(verbatim: specString(({ () -> Any in switch specString(vm.showCheckbox) {
case specString(true): return (specIncludes(vm.safeSelected, specGet(option, "value")) ? "u2611" : "u2610")
default: return (specIncludes(vm.safeSelected, specGet(option, "value")) ? "u2713" : "")
} })()))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("interactive"))
                  Text(verbatim: specString(specGet(option, "label")))
                    .font(.body.bold())
                    .foregroundStyle((specIncludes(vm.safeSelected, specGet(option, "value")) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-primary")))
                }
                .padding(ThemeManager.shared.size("spacing-2"))
                .opacity(CGFloat(0))
                .background(({ () -> Color in switch specString(specEq(idx, vm.highlightIndex)) {
case specString(true): return ThemeManager.shared.color("select-optionHover")
default: return ({ () -> Color in switch specString(specIncludes(vm.safeSelected, specGet(option, "value"))) {
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
          }
          .frame(maxHeight: CGFloat(280))
          .background(ThemeManager.shared.color("select-bg"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.size("select-radius")))
          .focusable()
          .onKeyPress(.downArrow) { Task { @MainActor in await vm.moveHighlight(1) }; return .handled }
          .onKeyPress(.upArrow) { Task { @MainActor in await vm.moveHighlight(-1) }; return .handled }
          .onKeyPress(.return) { Task { @MainActor in await vm.toggleHighlighted() }; return .handled }
          .onKeyPress(.init(" ")) { Task { @MainActor in await vm.toggleHighlighted() }; return .handled }
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

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.values, values) { vm.values = values }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.display, display) { vm.display = display }; if !specEq(vm.showCheckbox, showCheckbox) { vm.showCheckbox = showCheckbox }; if !specEq(vm.mode, mode) { vm.mode = mode } }
    .task(id: specPropsKey([options, values, placeholder, searchable, disabled, label, display, showCheckbox, mode])) { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.values, values) { vm.values = values }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.display, display) { vm.display = display }; if !specEq(vm.showCheckbox, showCheckbox) { vm.showCheckbox = showCheckbox }; if !specEq(vm.mode, mode) { vm.mode = mode } }
  }
}
