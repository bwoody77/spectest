import SwiftUI
import SpecRuntime

@Observable
final class TreeViewModel {
  var expanded: Any = [] as [Any]
  var expandMode: Any = "icon"
  var nodes: Any? = nil
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  var expandedIds: Any? = nil as Any? as Any
  var selectedIds: Any? = nil as Any? as Any
  init() {
    expandedIds = expanded
    selectedIds = selected
  }
  func handleToggle(_ id: Any) {
    if specIncludes(expandedIds, id) as? Bool ?? false {
      expandedIds = (expandedIds as? [Any] ?? []).filter { { eid in (specString(eid) != specString(id)) }($0) as? Bool ?? false }
      /* event callback */
    } else {
      expandedIds = specAdd(expandedIds, [id] as [Any])
      /* event callback */
    }
  }
  func handleSelect(_ id: Any) {
    if (specString(selection) == specString("single")) as? Bool ?? false {
      selectedIds = [id] as [Any]
    } else {
      if (specString(selection) == specString("multi")) as? Bool ?? false {
        if specIncludes(selectedIds, id) as? Bool ?? false {
          selectedIds = (selectedIds as? [Any] ?? []).filter { { sid in (specString(sid) != specString(id)) }($0) as? Bool ?? false }
        } else {
          selectedIds = specAdd(selectedIds, [id] as [Any])
        }
      }
    }
    /* event callback */
    /* event callback */
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct TreeView: View {
  @State private var vm = TreeViewModel()
  var expanded: Any = [] as [Any]
  var expandMode: Any = "icon"
  var nodes: Any? = nil
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  init(expanded: Any = [] as [Any], expandMode: Any = "icon", nodes: Any? = nil, selected: Any = [] as [Any], selection: Any = "none") { self._vm = State(initialValue: TreeViewModel()); self.expanded = expanded; self.expandMode = expandMode; self.nodes = nodes; self.selected = selected; self.selection = selection }
  var body: some View {
    VStack() {
      VStack() {
        ForEach(Array((vm.nodes as? [Any] ?? []).enumerated()), id: \.offset) { _idx, node in
          TreeNodeView(expandedIds: vm.expandedIds, expandMode: vm.expandMode, level: 1, node: node, selectedIds: vm.selectedIds, selectionMode: vm.selection)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.nodes = nodes; vm.selection = selection; vm.selected = selected; vm.expanded = expanded; vm.expandMode = expandMode }
  }
}
