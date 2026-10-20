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
    if specIncludes(expandedIds, id) {
      expandedIds = specFilter(expandedIds, { (eid: Any) -> Bool in return specNeq(eid, id) })
      /* event callback */
    } else {
      expandedIds = specAdd(expandedIds, [id] as [Any])
      /* event callback */
    }
  }
  func handleSelect(_ id: Any) {
    if specEq(selection, "single") {
      selectedIds = [id] as [Any]
    } else {
      if specEq(selection, "multi") {
        if specIncludes(selectedIds, id) {
          selectedIds = specFilter(selectedIds, { (sid: Any) -> Bool in return specNeq(sid, id) })
        } else {
          selectedIds = specAdd(selectedIds, [id] as [Any])
        }
      }
    }
    /* event callback */
    /* event callback */
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
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
        ForEach(Array(specArr(vm.nodes).enumerated()), id: \.offset) { _idx, node in
          TreeNodeView(expandedIds: vm.expandedIds, expandMode: vm.expandMode, level: 1, node: node, selectedIds: vm.selectedIds, selectionMode: vm.selection)
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.nodes, nodes) { vm.nodes = nodes }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.expanded, expanded) { vm.expanded = expanded }; if !specEq(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
    .task(id: specPropsKey([nodes, selection, selected, expanded, expandMode])) { if !specEq(vm.nodes, nodes) { vm.nodes = nodes }; if !specEq(vm.selection, selection) { vm.selection = selection }; if !specEq(vm.selected, selected) { vm.selected = selected }; if !specEq(vm.expanded, expanded) { vm.expanded = expanded }; if !specEq(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
  }
}
