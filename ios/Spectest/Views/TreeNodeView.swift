import SwiftUI
import SpecRuntime

@Observable
final class TreeNodeViewModel {
  var expandedIds: Any = [] as [Any]
  var expandMode: Any = "icon"
  var level: Any = 1
  var node: Any? = nil
  var selectedIds: Any = [] as [Any]
  var selectionMode: Any = "none"
  var isExpanded: Any { specIncludes(expandedIds, specGet(node, "id")) }
  var isSelected: Any { specIncludes(selectedIds, specGet(node, "id")) }
  var hasChildren: Any { (specGet(node, "children") != nil && (specDouble(specLength(specGet(node, "children"))) > specDouble(0))) }
  var toggleIcon: Any { ((isExpanded) as? Bool ?? false ? "▾" : "▸") }
  func handleToggle() {
    if specEq(expandMode, "icon") {
      /* event callback */
    }
  }
  func handleSelect() {
    if (specNeq(specGet(node, "disabled"), true) && specNeq(selectionMode, "none")) {
      /* event callback */
    }
  }
  func handleRowClick() {
    if specEq(expandMode, "row") {
      if (hasChildren) as? Bool ?? false {
        /* event callback */
      } else {
        handleSelect()
      }
    } else {
      handleSelect()
    }
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct TreeNodeView: View {
  @State private var vm = TreeNodeViewModel()
  var expandedIds: Any = [] as [Any]
  var expandMode: Any = "icon"
  var level: Any = 1
  var node: Any? = nil
  var selectedIds: Any = [] as [Any]
  var selectionMode: Any = "none"
  init(expandedIds: Any = [] as [Any], expandMode: Any = "icon", level: Any = 1, node: Any? = nil, selectedIds: Any = [] as [Any], selectionMode: Any = "none") { self._vm = State(initialValue: TreeNodeViewModel()); self.expandedIds = expandedIds; self.expandMode = expandMode; self.level = level; self.node = node; self.selectedIds = selectedIds; self.selectionMode = selectionMode }
  var body: some View {
    VStack() {
      VStack() {
        Button(action: { vm.handleRowClick() }) {
        HStack(alignment: .center, ) {
          Button(action: { vm.handleToggle() }) {
          VStack() {
            if (vm.hasChildren) as? Bool ?? false {
              Text(verbatim: specString(vm.toggleIcon))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          }
          .buttonStyle(.plain)
          VStack() {
            if specEq(vm.hasChildren, false) {
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          HStack(alignment: .center, ) {
            if specGet(vm.node, "icon") != nil {
              Image(systemName: specIconName(specString((specGet(vm.node, "icon") != nil ? specGet(vm.node, "icon") : ""))))
                .font(.system(size: specPx(16)))
                .foregroundStyle(Color(hex: "#496183" as? String ?? "transparent"))
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          Text(verbatim: specString(specGet(vm.node, "label")))
            .font(.body.bold())
            .foregroundStyle(Color(hex: ((vm.isSelected) as? Bool ?? false ? "#1677ff" : "#202732") as? String ?? "transparent"))
        }
        .padding(.top, CGFloat(4))
        .padding(.bottom, CGFloat(4))
        .opacity(specPx((specEq(specGet(vm.node, "disabled"), true) ? 0.5 : 1)))
        .hoverEffect(.highlight)
        }
        .buttonStyle(.plain)
        VStack() {
          if ((vm.isExpanded) as? Bool ?? false && (vm.hasChildren) as? Bool ?? false) {
            ForEach(Array(specArr(specGet(vm.node, "children")).enumerated()), id: \.offset) { _idx, child in
              TreeNodeView(expandedIds: vm.expandedIds, expandMode: vm.expandMode, level: specAdd(vm.level, 1), node: child, selectedIds: vm.selectedIds, selectionMode: vm.selectionMode)
            }
          }
        }
        .padding(.leading, CGFloat(20))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.node, node) { vm.node = node }; if !specEq(vm.level, level) { vm.level = level }; if !specEq(vm.expandedIds, expandedIds) { vm.expandedIds = expandedIds }; if !specEq(vm.selectedIds, selectedIds) { vm.selectedIds = selectedIds }; if !specEq(vm.selectionMode, selectionMode) { vm.selectionMode = selectionMode }; if !specEq(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
    .task(id: specPropsKey([node, level, expandedIds, selectedIds, selectionMode, expandMode])) { if !specEq(vm.node, node) { vm.node = node }; if !specEq(vm.level, level) { vm.level = level }; if !specEq(vm.expandedIds, expandedIds) { vm.expandedIds = expandedIds }; if !specEq(vm.selectedIds, selectedIds) { vm.selectedIds = selectedIds }; if !specEq(vm.selectionMode, selectionMode) { vm.selectionMode = selectionMode }; if !specEq(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
  }
}
