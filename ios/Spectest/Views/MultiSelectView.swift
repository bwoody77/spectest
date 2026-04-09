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
  var filteredOptions: Any { ((searchable as? Bool ?? false && (specString(query) != specString(""))) ? (safeOptions as? [Any] ?? []).filter { { o in specIncludes(((o as? [String: Any])?["label"] as? String ?? "").lowercased(), (query as? String ?? "").lowercased()) }($0) as? Bool ?? false } : safeOptions) }
  var selectedOptions: Any { (safeOptions as? [Any] ?? []).filter { { o in specIncludes(safeSelected, (o as? [String: Any])?["value"]) }($0) as? Bool ?? false } }
  var hasSelections: Any { ((specLength(safeSelected) as? Double ?? 0) > (0 as? Double ?? 0)) }
  var hasOptions: Any { ((specLength(filteredOptions) as? Double ?? 0) > (0 as? Double ?? 0)) }
  var displayPlaceholder: Any { ((specString(hasSelections) == specString(false)) ? placeholder : "") }
  var displayText: Any { ((selectedOptions as? [Any] ?? []).map { { o in (o as? [String: Any])?["label"] }($0) } as? [Any] ?? []).map { String(describing: $0) }.joined(separator: ", " as? String ?? "") }
  var isDropdownMode: Any { (specString(mode) == specString("dropdown")) }
  var showList: Any { ((specString(isDropdownMode) == specString(false)) || (specString(open) == specString(true))) }
  func toggleOpen() {
    if (specString(disabled) == specString(false)) as? Bool ?? false {
      open = (specString(open) == specString(false))
      query = ""
      highlightIndex = 0
    }
  }
  func openDropdown() {
    if ((specString(disabled) == specString(false)) && (specString(open) == specString(false))) as? Bool ?? false {
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
    if (specString(open) == specString(false)) as? Bool ?? false {
      open = true
    }
  }
  func toggleOption(_ val: Any) {
    if specIncludes(selected, val) as? Bool ?? false {
      selected = (selected as? [Any] ?? []).filter { { v in (specString(v) != specString(val)) }($0) as? Bool ?? false }
    } else {
      selected = ((selected as? [Any] ?? []) + ([val] as [Any] as? [Any] ?? []))
    }
    /* event callback */
  }
  func removeTag(_ val: Any) {
    selected = (selected as? [Any] ?? []).filter { { v in (specString(v) != specString(val)) }($0) as? Bool ?? false }
    /* event callback */
  }
  func selectAll() {
    selected = ((filteredOptions as? [Any] ?? []).filter { { o in (specString((o as? [String: Any])?["disabled"]) != specString(true)) }($0) as? Bool ?? false } as? [Any] ?? []).map { { o in (o as? [String: Any])?["value"] }($0) }
    /* event callback */
  }
  func clearAll() {
    selected = [] as [Any]
    /* event callback */
  }
  func moveHighlight(_ delta: Any) {
    if ((specLength(filteredOptions) as? Double ?? 0) > (0 as? Double ?? 0)) as? Bool ?? false {
      highlightIndex = wrapIndex(highlightIndex, delta, specLength(filteredOptions))
    }
  }
  func toggleHighlighted() {
    if (((specLength(filteredOptions) as? Double ?? 0) > (0 as? Double ?? 0)) && ((highlightIndex as? Double ?? 0) < (specLength(filteredOptions) as? Double ?? 0))) as? Bool ?? false {
      toggleOption(((filteredOptions as? [Any])?[highlightIndex as? Int ?? 0] as? [String: Any])?["value"])
    }
  }
  func removeLastTag() {
    if ((specLength(safeSelected) as? Double ?? 0) > (0 as? Double ?? 0)) as? Bool ?? false {
      selected = specSlice(selected, 0, ((specLength(selected) as? Double ?? 0) - (1 as? Double ?? 0)))
      /* event callback */
    }
  }
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
          if (specString(vm.label) != specString("")) {
            Text(specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
        }

        VStack(spacing: CGFloat(4)) {
          if vm.isDropdownMode as? Bool ?? false {
            HStack(alignment: .center, spacing: CGFloat(4)) {
              HStack(alignment: .center, spacing: CGFloat(4)) {
                if (vm.hasSelections as? Bool ?? false && (specString(vm.display) == specString("chips"))) {
                  ForEach(Array((vm.selectedOptions as? [Any] ?? []).enumerated()), id: \.offset) { _idx, opt in
                    HStack(alignment: .center, spacing: CGFloat(4)) {
                      Text(specString((opt as? [String: Any])?["label"]))
                        .font(.body.bold())
                        .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                      VStack() {
                        Text(specString("u00D7"))
                          .font(.body.bold())
                          .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                      }

                      .onTapGesture { vm.removeTag((opt as? [String: Any])?["value"]) }
                    }
                    .padding(.leading, CGFloat(8))
                    .padding(.trailing, CGFloat(4))
                    .background(ThemeManager.shared.color("semantic.on-destructive"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  }
                }
              }

              VStack() {
                if (vm.hasSelections as? Bool ?? false && (specString(vm.display) == specString("text"))) {
                  Text(specString(vm.displayText))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
                }
              }

              HStack(alignment: .center, ) {
                VStack() {
                  if (specString(vm.hasSelections) == specString(false)) {
                    Text(specString(vm.placeholder))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                  }
                }

                Text(specString("u25BE"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              }
              .frame(minHeight: CGFloat(0))
              .frame(minWidth: CGFloat(0))
              .frame(maxWidth: .infinity)
              .onTapGesture { vm.toggleOpen() }
            }
            .padding(CGFloat(8))
            .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.5 : 1)))
            .frame(minHeight: CGFloat(40))
            .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          }
          VStack() {
            if (specString(vm.open) == specString(true)) {
            }
          }

          .onTapGesture { vm.closeDropdown() }
          VStack() {
            if (specString(vm.open) == specString(true)) {
              VStack() {
                if vm.searchable as? Bool ?? false {
                  TextField(specString("Search..."), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
                }
              }
              .padding(CGFloat(8))
            }
            HStack(alignment: .center, spacing: CGFloat(8)) {
              VStack() {
                Text(specString("Select all"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
              }

              .onTapGesture { vm.selectAll() }
              VStack() {
                Text(specString("Clear all"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
              }

              .onTapGesture { vm.clearAll() }
            }
            .padding(CGFloat(8))
            VStack() {
              if vm.hasOptions as? Bool ?? false {
                LazyVStack(spacing: CGFloat(8)) {
                  ForEach(Array((vm.filteredOptions as? [Any] ?? []).enumerated()), id: \.offset) { idx, option in
                    HStack(alignment: .center, spacing: CGFloat(8)) {
                      Text(specString(({ () -> Any in switch specString(vm.showCheckbox) {
case specString(true): return ((specIncludes(vm.safeSelected, (option as? [String: Any])?["value"])) as? Bool ?? false ? "u2611" : "u2610")
default: return ((specIncludes(vm.safeSelected, (option as? [String: Any])?["value"])) as? Bool ?? false ? "u2713" : "")
} })()))
                        .font(.body.bold())
                        .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                      Text(specString((option as? [String: Any])?["label"]))
                        .font(.body.bold())
                        .foregroundStyle(Color(hex: ((specIncludes(vm.safeSelected, (option as? [String: Any])?["value"])) as? Bool ?? false ? "#1677ff" : "#202732") as? String ?? "#000"))
                    }
                    .padding(CGFloat(8))
                    .opacity(CGFloat(0))
                    .background(Color(hex: ({ () -> Any in switch specString((specString(idx) == specString(vm.highlightIndex))) {
case specString(true): return "#f1f5f9"
default: return ({ () -> Any in switch specString(specIncludes(vm.safeSelected, (option as? [String: Any])?["value"])) {
case specString(true): return "#eef2ff"
default: return "transparent"
} })()
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                    .onTapGesture { vm.toggleOption((option as? [String: Any])?["value"]) }
                  }
                }
              }
            }

            HStack(alignment: .center, ) {
              if (specString(vm.hasOptions) == specString(false)) {
                Text(specString("No options"))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
              }
            }
            .padding(CGFloat(12))
          }
          .padding(CGFloat(4))
          .frame(maxHeight: CGFloat(280))
          .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .scrollIndicators(.visible)
        }

        VStack(spacing: CGFloat(4)) {
          if (specString(vm.isDropdownMode) == specString(false)) {
            VStack() {
              if vm.hasSelections as? Bool ?? false {
                Text(specString(specAdd(specLength(vm.safeSelected), " selected")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
              }
            }
            .padding(CGFloat(8))
          }
          VStack() {
            if vm.searchable as? Bool ?? false {
              TextField(specString("Search..."), text: Binding(get: { vm.query as? String ?? "" }, set: { vm.query = $0 }))
            }
          }
          .padding(CGFloat(8))
          HStack(alignment: .center, spacing: CGFloat(8)) {
            VStack() {
              Text(specString("Select all"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }

            .onTapGesture { vm.selectAll() }
            VStack() {
              Text(specString("Clear all"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }

            .onTapGesture { vm.clearAll() }
          }
          .padding(CGFloat(8))
          VStack() {
            if vm.hasOptions as? Bool ?? false {
              LazyVStack(spacing: CGFloat(8)) {
                ForEach(Array((vm.filteredOptions as? [Any] ?? []).enumerated()), id: \.offset) { idx, option in
                  HStack(alignment: .center, spacing: CGFloat(8)) {
                    Text(specString(({ () -> Any in switch specString(vm.showCheckbox) {
case specString(true): return ((specIncludes(vm.safeSelected, (option as? [String: Any])?["value"])) as? Bool ?? false ? "u2611" : "u2610")
default: return ((specIncludes(vm.safeSelected, (option as? [String: Any])?["value"])) as? Bool ?? false ? "u2713" : "")
} })()))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
                    Text(specString((option as? [String: Any])?["label"]))
                      .font(.body.bold())
                      .foregroundStyle(Color(hex: ((specIncludes(vm.safeSelected, (option as? [String: Any])?["value"])) as? Bool ?? false ? "#1677ff" : "#202732") as? String ?? "#000"))
                  }
                  .padding(CGFloat(8))
                  .opacity(CGFloat(0))
                  .background(Color(hex: ({ () -> Any in switch specString((specString(idx) == specString(vm.highlightIndex))) {
case specString(true): return "#f1f5f9"
default: return ({ () -> Any in switch specString(specIncludes(vm.safeSelected, (option as? [String: Any])?["value"])) {
case specString(true): return "#eef2ff"
default: return "transparent"
} })()
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  .onTapGesture { vm.toggleOption((option as? [String: Any])?["value"]) }
                }
              }
            }
          }
          .frame(maxHeight: CGFloat(280))
          .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
          .scrollIndicators(.visible)
          HStack(alignment: .center, ) {
            if (specString(vm.hasOptions) == specString(false)) {
              Text(specString("No options"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }
          .padding(CGFloat(12))
        }

      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.options = options; vm.values = values; vm.placeholder = placeholder; vm.searchable = searchable; vm.disabled = disabled; vm.label = label; vm.display = display; vm.showCheckbox = showCheckbox; vm.mode = mode }
  }
}
