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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
      VStack(spacing: CGFloat(4)) {
        VStack() {
          if specNeq(vm.label, "") {
            Text(verbatim: specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
        }

        VStack(spacing: CGFloat(4)) {
          if (vm.isDropdownMode) as? Bool ?? false {
            HStack(alignment: .center, spacing: CGFloat(4)) {
              HStack(alignment: .center, spacing: CGFloat(4)) {
                if ((vm.hasSelections) as? Bool ?? false && specEq(vm.display, "chips")) {
                  ForEach(Array(specArr(vm.selectedOptions).enumerated()), id: \.offset) { _idx, opt in
                    HStack(alignment: .center, spacing: CGFloat(4)) {
                      Text(verbatim: specString(specGet(opt, "label")))
                        .font(.body.bold())
                        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                      Button(action: { vm.removeTag(specGet(opt, "value")) }) {
                      VStack() {
                        Text(verbatim: specString("u00D7"))
                          .font(.body.bold())
                          .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                      }

                      }
                      .buttonStyle(.plain)
                    }
                    .padding(.leading, CGFloat(8))
                    .padding(.trailing, CGFloat(4))
                    .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  }
                }
              }

              VStack() {
                if ((vm.hasSelections) as? Bool ?? false && specEq(vm.display, "text")) {
                  Text(verbatim: specString(vm.displayText))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
              }

              Button(action: { vm.toggleOpen() }) {
              HStack(alignment: .center, ) {
                VStack() {
                  if specEq(vm.hasSelections, false) {
                    Text(verbatim: specString(vm.placeholder))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                  }
                }

                Text(verbatim: specString("u25BE"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              }
              .frame(minHeight: CGFloat(0))
              .frame(minWidth: CGFloat(0))
              .frame(maxWidth: .infinity)
              }
              .buttonStyle(.plain)
            }
            .padding(CGFloat(8))
            .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.5 : 1)))
            .frame(minHeight: CGFloat(40))
            .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          }
        }

        .overlay {
          if specEq(vm.open, true) {
            ZStack {
              Color.black.opacity(0.15)
                .ignoresSafeArea()
                .onTapGesture { vm.closeDropdown() }
              if specEq(vm.open, true) {
              }
            }
          }
        }
        .overlay {
          if specEq(vm.open, true) {
            ZStack {
              if specEq(vm.open, true) {
                VStack() {
                  if (vm.searchable) as? Bool ?? false {
                    TextField(specString("Search..."), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
                  }
                }
                .padding(CGFloat(8))
              }
              HStack(alignment: .center, spacing: CGFloat(8)) {
                Button(action: { vm.selectAll() }) {
                VStack() {
                  Text(verbatim: specString("Select all"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                }

                }
                .buttonStyle(.plain)
                Button(action: { vm.clearAll() }) {
                VStack() {
                  Text(verbatim: specString("Clear all"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                }

                }
                .buttonStyle(.plain)
              }
              .padding(CGFloat(8))
              VStack() {
                if (vm.hasOptions) as? Bool ?? false {
                  ForEach(Array(specArr(vm.filteredOptions).enumerated()), id: \.offset) { idx, option in
                    Button(action: { vm.toggleOption(specGet(option, "value")) }) {
                    HStack(alignment: .center, spacing: CGFloat(8)) {
                      Text(verbatim: specString(({ () -> Any in switch specString(vm.showCheckbox) {
case specString(true): return (specIncludes(vm.safeSelected, specGet(option, "value")) ? "u2611" : "u2610")
default: return (specIncludes(vm.safeSelected, specGet(option, "value")) ? "u2713" : "")
} })()))
                        .font(.body.bold())
                        .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                      Text(verbatim: specString(specGet(option, "label")))
                        .font(.body.bold())
                        .foregroundStyle(Color(hex: (specIncludes(vm.safeSelected, specGet(option, "value")) ? "#1677ff" : "#202732") as? String ?? "transparent"))
                    }
                    .padding(CGFloat(8))
                    .opacity(CGFloat(0))
                    .background(Color(hex: ({ () -> Any in switch specString(specEq(idx, vm.highlightIndex)) {
case specString(true): return "#f1f5f9"
default: return ({ () -> Any in switch specString(specIncludes(vm.safeSelected, specGet(option, "value"))) {
case specString(true): return "#eef2ff"
default: return "transparent"
} })()
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                    }
                    .buttonStyle(.plain)
                  }
                }
              }

              HStack(alignment: .center, ) {
                if specEq(vm.hasOptions, false) {
                  Text(verbatim: specString("No options"))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }
              }
              .padding(CGFloat(12))
            }
          }
        }
        VStack(spacing: CGFloat(4)) {
          if specEq(vm.isDropdownMode, false) {
            VStack() {
              if (vm.hasSelections) as? Bool ?? false {
                Text(verbatim: specString(specAdd(specLength(vm.safeSelected), " selected")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
            }
            .padding(CGFloat(8))
          }
          VStack() {
            if (vm.searchable) as? Bool ?? false {
              TextField(specString("Search..."), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
            }
          }
          .padding(CGFloat(8))
          HStack(alignment: .center, spacing: CGFloat(8)) {
            Button(action: { vm.selectAll() }) {
            VStack() {
              Text(verbatim: specString("Select all"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }

            }
            .buttonStyle(.plain)
            Button(action: { vm.clearAll() }) {
            VStack() {
              Text(verbatim: specString("Clear all"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }

            }
            .buttonStyle(.plain)
          }
          .padding(CGFloat(8))
          ScrollView(.horizontal, showsIndicators: true) {
          VStack() {
            if (vm.hasOptions) as? Bool ?? false {
              ForEach(Array(specArr(vm.filteredOptions).enumerated()), id: \.offset) { idx, option in
                Button(action: { vm.toggleOption(specGet(option, "value")) }) {
                HStack(alignment: .center, spacing: CGFloat(8)) {
                  Text(verbatim: specString(({ () -> Any in switch specString(vm.showCheckbox) {
case specString(true): return (specIncludes(vm.safeSelected, specGet(option, "value")) ? "u2611" : "u2610")
default: return (specIncludes(vm.safeSelected, specGet(option, "value")) ? "u2713" : "")
} })()))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                  Text(verbatim: specString(specGet(option, "label")))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: (specIncludes(vm.safeSelected, specGet(option, "value")) ? "#1677ff" : "#202732") as? String ?? "transparent"))
                }
                .padding(CGFloat(8))
                .opacity(CGFloat(0))
                .background(Color(hex: ({ () -> Any in switch specString(specEq(idx, vm.highlightIndex)) {
case specString(true): return "#f1f5f9"
default: return ({ () -> Any in switch specString(specIncludes(vm.safeSelected, specGet(option, "value"))) {
case specString(true): return "#eef2ff"
default: return "transparent"
} })()
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                }
                .buttonStyle(.plain)
              }
            }
          }
          }
          .frame(maxHeight: CGFloat(280))
          .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          HStack(alignment: .center, ) {
            if specEq(vm.hasOptions, false) {
              Text(verbatim: specString("No options"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }
          .padding(CGFloat(12))
        }

      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.values, values) { vm.values = values }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.display, display) { vm.display = display }; if !specEq(vm.showCheckbox, showCheckbox) { vm.showCheckbox = showCheckbox }; if !specEq(vm.mode, mode) { vm.mode = mode } }
    .task(id: specPropsKey([options, values, placeholder, searchable, disabled, label, display, showCheckbox, mode])) { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.values, values) { vm.values = values }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.label, label) { vm.label = label }; if !specEq(vm.display, display) { vm.display = display }; if !specEq(vm.showCheckbox, showCheckbox) { vm.showCheckbox = showCheckbox }; if !specEq(vm.mode, mode) { vm.mode = mode } }
  }
}
