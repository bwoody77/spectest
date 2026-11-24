import SwiftUI
import SpecRuntime

@Observable
@MainActor
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
  func _specReseedFromParams() {
    selectedIds = selected
  }
  var filteredItems: Any { (specNeq(searchQuery, "") ? specFilter(items, { (item: Any) -> Bool in return specIncludes(specToLowerCase(specGet(item, "label")), specToLowerCase(searchQuery)) }) : items) }
  var hasItems: Any { specGt(specLength(filteredItems), 0) }
  func setSearch(_ v: Any) {
    searchQuery = v
    dispatch("search", [v] as [Any])
  }
  func handleSelect(_ id: Any) {
    if specEq(selection, "single") {
      selectedIds = [id] as [Any]
      dispatch("selectionChange", [selectedIds] as [Any])
    } else {
      if specEq(selection, "multi") {
        if specIncludes(selectedIds, id) {
          selectedIds = specFilter(selectedIds, { (sid: Any) -> Bool in return specNeq(sid, id) })
        } else {
          selectedIds = specAdd(selectedIds, [id] as [Any])
        }
        dispatch("selectionChange", [selectedIds] as [Any])
      }
    }
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct ListView: View {
  @State private var vm = ListViewModel()
  var height: Any = ""
  var items: Any = [] as [Any]
  var searchable: Any = false
  var searchPlaceholder: Any = "Search..."
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(height: Any = "", items: Any = [] as [Any], searchable: Any = false, searchPlaceholder: Any = "Search...", selected: Any = [] as [Any], selection: Any = "none", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = ListViewModel(); _m.height = height; _m.items = items; _m.searchable = searchable; _m.searchPlaceholder = searchPlaceholder; _m.selected = selected; _m.selection = selection; _m.onDispatch = onDispatch; _m._specReseedFromParams(); self._vm = State(initialValue: _m); self.height = height; self.items = items; self.searchable = searchable; self.searchPlaceholder = searchPlaceholder; self.selected = selected; self.selection = selection; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(height) + "\u{1}" + specChangeKey(items) + "\u{1}" + specChangeKey(searchable) + "\u{1}" + specChangeKey(searchPlaceholder) + "\u{1}" + specChangeKey(selected) + "\u{1}" + specChangeKey(selection) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        if (vm.searchable) as? Bool ?? false {
        VStack(alignment: .leading, spacing: 0) {
          if (vm.searchable) as? Bool ?? false {
            SpecTextField(specString(vm.searchPlaceholder), text: Binding(get: { vm.searchQuery as? String ?? "" }, set: { newValue in vm.searchQuery = newValue; let v: Any = newValue; vm.setSearch(v) }))
              .textFieldStyle(.roundedBorder)
          }
        }
        .padding(.bottom, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
        .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
        .frame(maxWidth: .infinity, alignment: .leading)
        .specBorderSides(nil, top: nil, right: nil, bottom: ThemeManager.shared.rawToken("borders-default"), left: nil, radius: CGFloat(0))
        }
        ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(Array(specArr(vm.filteredItems).enumerated()), id: \.offset) { _idx, item in
            Button(action: { specClick { vm.handleSelect(specGet(item, "id")) } }) {
            HStack(alignment: .center, spacing: 0) {
              Text(verbatim: specString(specGet(item, "label")))
                .font(.body)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                .foregroundStyle((specIncludes(vm.selectedIds, specGet(item, "id")) ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-primary")))
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
            .frame(maxWidth: .infinity, alignment: .center)
            .background((specIncludes(vm.selectedIds, specGet(item, "id")) ? ThemeManager.shared.color("surface-raised") : Color.clear))
            .opacity(CGFloat(0))
            .hoverEffect(.highlight)
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
          }
        }
        }

        if specEq(vm.hasItems, false) {
        HStack(alignment: .center, spacing: 0) {
          Spacer(minLength: 0)
          Text(verbatim: specString("No items"))
            .font(.body)
            .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
            .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
          Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(specPx(ThemeManager.shared.rawToken("spacing-3")))
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.height = height
      vm.items = items
      vm.searchable = searchable
      vm.searchPlaceholder = searchPlaceholder
      vm.selected = selected
      vm.selection = selection
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.items, items) { vm.items = items }; if !specSame(vm.selection, selection) { vm.selection = selection }; if !specSame(vm.selected, selected) { vm.selected = selected }; if !specSame(vm.searchable, searchable) { vm.searchable = searchable }; if !specSame(vm.searchPlaceholder, searchPlaceholder) { vm.searchPlaceholder = searchPlaceholder }; if !specSame(vm.height, height) { vm.height = height } }
    .task(id: specPropsKey([items, selection, selected, searchable, searchPlaceholder, height])) { if !specSame(vm.items, items) { vm.items = items }; if !specSame(vm.selection, selection) { vm.selection = selection }; if !specSame(vm.selected, selected) { vm.selected = selected }; if !specSame(vm.searchable, searchable) { vm.searchable = searchable }; if !specSame(vm.searchPlaceholder, searchPlaceholder) { vm.searchPlaceholder = searchPlaceholder }; if !specSame(vm.height, height) { vm.height = height } }
  }
}
