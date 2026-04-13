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
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
          }
        }
        .padding(CGFloat(8))
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
        VStack() {
          ForEach(Array(specArr(vm.filteredItems).enumerated()), id: \.offset) { _idx, item in
            HStack(alignment: .center, ) {
              Text(verbatim: specString(specGet(item, "label")))
                .font(.body.bold())
                .foregroundStyle(Color(hex: (specIncludes(vm.selectedIds, specGet(item, "id")) ? "#1677ff" : "#202732") as? String ?? "#000"))
            }
            .padding(CGFloat(8))
            .background(Color(hex: (specIncludes(vm.selectedIds, specGet(item, "id")) ? "#ffffff" : "transparent") as? String ?? "#000"))
            .opacity(CGFloat(0))
            .background(Color(hex: (specIncludes(vm.selectedIds, specGet(item, "id")) ? "#ffffff" : "transparent") as? String ?? "#000"))
            .onTapGesture { vm.handleSelect(specGet(item, "id")) }
          }
        }
        }

        HStack(alignment: .center, ) {
          if specEq(vm.hasItems, false) {
            Text(verbatim: specString("No items"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
          }
        }
        .padding(CGFloat(12))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.searchPlaceholder, searchPlaceholder) { vm.searchPlaceholder = searchPlaceholder }; if !specEq(vm.height, height) { vm.height = height } }
    .task(id: specPropsKey([items, selection, selected, searchable, searchPlaceholder, height])) { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.searchable, searchable) { vm.searchable = searchable }; if !specEq(vm.searchPlaceholder, searchPlaceholder) { vm.searchPlaceholder = searchPlaceholder }; if !specEq(vm.height, height) { vm.height = height } }
  }
}
