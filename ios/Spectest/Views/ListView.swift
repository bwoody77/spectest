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
  var filteredItems: Any { ((specString(searchQuery) != specString("")) ? (items as? [Any] ?? []).filter { { item in specIncludes(((item as? [String: Any])?["label"] as? String ?? "").lowercased(), (searchQuery as? String ?? "").lowercased()) }($0) as? Bool ?? false } : items) }
  var hasItems: Any { ((specLength(filteredItems) as? Double ?? 0) > (0 as? Double ?? 0)) }
  func setSearch(_ v: Any) {
    searchQuery = v
    /* event callback */
  }
  func handleSelect(_ id: Any) {
    if (specString(selection) == specString("single")) as? Bool ?? false {
      selectedIds = [id] as [Any]
      /* event callback */
    } else {
      if (specString(selection) == specString("multi")) as? Bool ?? false {
        if specIncludes(selectedIds, id) as? Bool ?? false {
          selectedIds = (selectedIds as? [Any] ?? []).filter { { sid in (specString(sid) != specString(id)) }($0) as? Bool ?? false }
        } else {
          selectedIds = specAdd(selectedIds, [id] as [Any])
        }
        /* event callback */
      }
    }
  }
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
          if vm.searchable as? Bool ?? false {
            TextField(specString(vm.searchPlaceholder), text: Binding(get: { vm.searchQuery as? String ?? "" }, set: { vm.searchQuery = $0 }))
          }
        }
        .padding(CGFloat(8))
        VStack() {
          LazyVStack(spacing: CGFloat(8)) {
            ForEach(Array((vm.filteredItems as? [Any] ?? []).enumerated()), id: \.offset) { _idx, item in
              HStack(alignment: .center, ) {
                Text(specString((item as? [String: Any])?["label"]))
                  .font(.body.bold())
                  .foregroundStyle(Color(hex: ((specIncludes(vm.selectedIds, (item as? [String: Any])?["id"])) as? Bool ?? false ? "#1677ff" : "#202732") as? String ?? "#000"))
              }
              .padding(CGFloat(8))
              .background(Color(hex: ((specIncludes(vm.selectedIds, (item as? [String: Any])?["id"])) as? Bool ?? false ? "#ffffff" : "transparent") as? String ?? "#000"))
              .opacity(CGFloat(0))
              .background(Color(hex: ((specIncludes(vm.selectedIds, (item as? [String: Any])?["id"])) as? Bool ?? false ? "#ffffff" : "transparent") as? String ?? "#000"))
              .onTapGesture { vm.handleSelect((item as? [String: Any])?["id"]) }
            }
          }
        }
        .scrollIndicators(.visible)
        HStack(alignment: .center, ) {
          if (specString(vm.hasItems) == specString(false)) {
            Text(specString("No items"))
              .font(.body.bold())
              .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
          }
        }
        .padding(CGFloat(12))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.items = items; vm.selection = selection; vm.selected = selected; vm.searchable = searchable; vm.searchPlaceholder = searchPlaceholder; vm.height = height }
  }
}
