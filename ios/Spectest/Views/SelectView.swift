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
