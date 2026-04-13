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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
      VStack(spacing: CGFloat(4)) {
        VStack() {
          if specNeq(vm.label, "") {
            Text(verbatim: specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
        }

        Button(action: { vm.toggleOpen() }) {
        HStack(alignment: .center, ) {
          Text(verbatim: specString(vm.displayText))
            .font(.body.bold())
            .foregroundStyle(Color(hex: (vm.selectedOption != nil ? "#202732" : "#92a2b9") as? String ?? "transparent"))
          Text(verbatim: specString("u25BE"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
        }
        .padding(CGFloat(8))
        .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.5 : 1)))
        .frame(minHeight: CGFloat(40))
        .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        }
        .buttonStyle(.plain)
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
            VStack() {
              if (vm.hasOptions) as? Bool ?? false {
                ForEach(Array(specArr(vm.filteredOptions).enumerated()), id: \.offset) { idx, option in
                  Button(action: { vm.selectOption(specGet(option, "value")) }) {
                  VStack() {
                    Text(verbatim: specString(specGet(option, "label")))
                      .font(.body.bold())
                      .foregroundStyle(Color(hex: (specEq(specGet(option, "value"), vm.value) ? "#1677ff" : "#202732") as? String ?? "transparent"))
                  }
                  .padding(CGFloat(8))
                  .background(Color(hex: ({ () -> Any in switch specString(specEq(idx, vm.highlightIndex)) {
case specString(true): return "#f1f5f9"
default: return ({ () -> Any in switch specString(specEq(specGet(option, "value"), vm.value)) {
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
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.label, label) { vm.label = label } }
    .task(id: specPropsKey([options, value, placeholder, searchable, disabled, label])) { if !specEq(vm.options, options) { vm.options = options }; if !specEq(vm.value, value) { vm.value = value }; if !specEq(vm.placeholder, placeholder) { vm.placeholder = placeholder }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.disabled, disabled) { vm.disabled = disabled }; if !specEq(vm.label, label) { vm.label = label } }
  }
}
