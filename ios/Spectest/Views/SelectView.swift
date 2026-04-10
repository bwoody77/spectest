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
  var filteredOptions: Any { ((searchable as? Bool ?? false && (specString(query) != specString(""))) ? (safeOptions as? [Any] ?? []).filter { { o in specIncludes(((o as? [String: Any])?["label"] as? String ?? "").lowercased(), (query as? String ?? "").lowercased()) }($0) as? Bool ?? false } : safeOptions) }
  var selectedOption: Any { (safeOptions as? [Any] ?? []).first(where: { { o in (specString((o as? [String: Any])?["value"]) == specString(value)) }($0) as? Bool ?? false }) }
  var displayText: Any { (selectedOption != nil ? (selectedOption as? [String: Any])?["label"] : placeholder) }
  var hasOptions: Any { (specDouble(specLength(filteredOptions)) > specDouble(0)) }
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
    if (specDouble(specLength(filteredOptions)) > specDouble(0)) as? Bool ?? false {
      highlightIndex = wrapIndex(highlightIndex, delta, specLength(filteredOptions))
    }
  }
  func selectHighlighted() {
    if ((specDouble(specLength(filteredOptions)) > specDouble(0)) && (specDouble(highlightIndex) < specDouble(specLength(filteredOptions)))) as? Bool ?? false {
      selectOption(((filteredOptions as? [Any])?[highlightIndex as? Int ?? 0] as? [String: Any])?["value"])
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
          if (specString(vm.label) != specString("")) {
            Text(specString(vm.label))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
          }
        }

        HStack(alignment: .center, ) {
          Text(specString(vm.displayText))
            .font(.body.bold())
            .foregroundStyle(Color(hex: (vm.selectedOption != nil ? "#202732" : "#92a2b9") as? String ?? "#000"))
          Text(specString("u25BE"))
            .font(.body.bold())
            .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
        }
        .padding(CGFloat(8))
        .opacity(specPx(((vm.disabled) as? Bool ?? false ? 0.5 : 1)))
        .frame(minHeight: CGFloat(40))
        .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .onTapGesture { vm.toggleOpen() }
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
          VStack() {
            if vm.hasOptions as? Bool ?? false {
              LazyVStack(spacing: CGFloat(8)) {
                ForEach(Array((vm.filteredOptions as? [Any] ?? []).enumerated()), id: \.offset) { idx, option in
                  VStack() {
                    Text(specString((option as? [String: Any])?["label"]))
                      .font(.body.bold())
                      .foregroundStyle(Color(hex: ((specString((option as? [String: Any])?["value"]) == specString(vm.value)) ? "#1677ff" : "#202732") as? String ?? "#000"))
                  }
                  .padding(CGFloat(8))
                  .background(Color(hex: ({ () -> Any in switch specString((specString(idx) == specString(vm.highlightIndex))) {
case specString(true): return "#f1f5f9"
default: return ({ () -> Any in switch specString((specString((option as? [String: Any])?["value"]) == specString(vm.value))) {
case specString(true): return "#eef2ff"
default: return "transparent"
} })()
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("sm")))
                  .onTapGesture { vm.selectOption((option as? [String: Any])?["value"]) }
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
        .frame(maxHeight: CGFloat(240))
        .background(Color(hex: "#fff"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
        .scrollIndicators(.visible)
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.options = options; vm.value = value; vm.placeholder = placeholder; vm.searchable = searchable; vm.disabled = disabled; vm.label = label }
  }
}
