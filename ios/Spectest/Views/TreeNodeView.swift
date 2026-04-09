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
  var isExpanded: Any { specIncludes(expandedIds, (node as? [String: Any])?["id"]) }
  var isSelected: Any { specIncludes(selectedIds, (node as? [String: Any])?["id"]) }
  var hasChildren: Any { ((node as? [String: Any])?["children"] != nil && ((specLength((node as? [String: Any])?["children"]) as? Double ?? 0) > (0 as? Double ?? 0))) }
  var toggleIcon: Any { ((isExpanded) as? Bool ?? false ? "▾" : "▸") }
  func handleToggle() {
    if (specString(expandMode) == specString("icon")) as? Bool ?? false {
      /* event callback */
    }
  }
  func handleSelect() {
    if ((specString((node as? [String: Any])?["disabled"]) != specString(true)) && (specString(selectionMode) != specString("none"))) as? Bool ?? false {
      /* event callback */
    }
  }
  func handleRowClick() {
    if (specString(expandMode) == specString("row")) as? Bool ?? false {
      if hasChildren as? Bool ?? false {
        /* event callback */
      } else {
        handleSelect()
      }
    } else {
      handleSelect()
    }
  }
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
        HStack(alignment: .center, ) {
          VStack() {
            if vm.hasChildren as? Bool ?? false {
              Text(specString(vm.toggleIcon))
                .font(.body.bold())
                .foregroundStyle(.secondary)
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          .onTapGesture { vm.handleToggle() }
          VStack() {
            if (specString(vm.hasChildren) == specString(false)) {
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          HStack(alignment: .center, ) {
            if (vm.node as? [String: Any])?["icon"] != nil {
              Image(systemName: specIconName(specString(((vm.node as? [String: Any])?["icon"] != nil ? (vm.node as? [String: Any])?["icon"] : ""))))
                .font(.system(size: specPx(16)))
                .foregroundStyle(Color(hex: "#496183" as? String ?? "#000"))
            }
          }
          .frame(width: CGFloat(20))
          .frame(minWidth: CGFloat(20))
          Text(specString((vm.node as? [String: Any])?["label"]))
            .font(.body.bold())
            .foregroundStyle(Color(hex: ((vm.isSelected) as? Bool ?? false ? "#1677ff" : "#202732") as? String ?? "#000"))
        }
        .padding(.top, CGFloat(4))
        .padding(.bottom, CGFloat(4))
        .opacity(specPx(((specString((vm.node as? [String: Any])?["disabled"]) == specString(true)) ? 0.5 : 1)))
        .onTapGesture { vm.handleRowClick() }
        VStack() {
          if (vm.isExpanded as? Bool ?? false && vm.hasChildren as? Bool ?? false) as? Bool ?? false {
            ForEach(Array(((vm.node as? [String: Any])?["children"] as? [Any] ?? []).enumerated()), id: \.offset) { _idx, child in
              TreeNodeView(expandedIds: vm.expandedIds, expandMode: vm.expandMode, level: specAdd(vm.level, 1), node: child, selectedIds: vm.selectedIds, selectionMode: vm.selectionMode)
            }
          }
        }
        .padding(.leading, CGFloat(20))
      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.node = node; vm.level = level; vm.expandedIds = expandedIds; vm.selectedIds = selectedIds; vm.selectionMode = selectionMode; vm.expandMode = expandMode }
  }
}
