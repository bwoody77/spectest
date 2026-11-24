import SwiftUI
import SpecRuntime

@Observable
@MainActor
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
  func _specReseedFromParams() {
    expandedIds = expanded
    selectedIds = selected
  }
  func handleToggle(_ id: Any) {
    if specIncludes(expandedIds, id) {
      expandedIds = specFilter(expandedIds, { (eid: Any) -> Bool in return specNeq(eid, id) })
      dispatch("collapse", [id] as [Any])
    } else {
      expandedIds = specAdd(expandedIds, [id] as [Any])
      dispatch("expand", [id] as [Any])
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
    dispatch("select", [id] as [Any])
    dispatch("selectionChange", [selectedIds] as [Any])
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct TreeView: View {
  @State private var vm = TreeViewModel()
  var expanded: Any = [] as [Any]
  var expandMode: Any = "icon"
  var nodes: Any? = nil
  var selected: Any = [] as [Any]
  var selection: Any = "none"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(expanded: Any = [] as [Any], expandMode: Any = "icon", nodes: Any? = nil, selected: Any = [] as [Any], selection: Any = "none", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TreeViewModel(); _m.expanded = expanded; _m.expandMode = expandMode; _m.nodes = nodes; _m.selected = selected; _m.selection = selection; _m.onDispatch = onDispatch; _m._specReseedFromParams(); self._vm = State(initialValue: _m); self.expanded = expanded; self.expandMode = expandMode; self.nodes = nodes; self.selected = selected; self.selection = selection; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(expanded) + "\u{1}" + specChangeKey(expandMode) + "\u{1}" + specChangeKey(nodes) + "\u{1}" + specChangeKey(selected) + "\u{1}" + specChangeKey(selection) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        ForEach(Array(specArr(vm.nodes).enumerated()), id: \.offset) { _idx, node in
          TreeNodeView(expandedIds: vm.expandedIds, expandMode: vm.expandMode, level: 1, node: node, selectedIds: vm.selectedIds, selectionMode: vm.selection, onDispatch: { specEvent, specPayload in
            _ = specPayload
            switch specString(specEvent) {
            case "toggle":
              let specArgs = specArr(specPayload)
              let id: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.handleToggle(id)
            case "select":
              let specArgs = specArr(specPayload)
              let id: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.handleSelect(id)
            default: break
            }
          })
        }
      }
      .accessibilityLabel(specString("Tree navigation"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.expanded = expanded
      vm.expandMode = expandMode
      vm.nodes = nodes
      vm.selected = selected
      vm.selection = selection
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.nodes, nodes) { vm.nodes = nodes }; if !specSame(vm.selection, selection) { vm.selection = selection }; if !specSame(vm.selected, selected) { vm.selected = selected }; if !specSame(vm.expanded, expanded) { vm.expanded = expanded }; if !specSame(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
    .task(id: specPropsKey([nodes, selection, selected, expanded, expandMode])) { if !specSame(vm.nodes, nodes) { vm.nodes = nodes }; if !specSame(vm.selection, selection) { vm.selection = selection }; if !specSame(vm.selected, selected) { vm.selected = selected }; if !specSame(vm.expanded, expanded) { vm.expanded = expanded }; if !specSame(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
  }
}
