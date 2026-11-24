import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TreeNodeViewModel {
  var expandedIds: Any = [] as [Any]
  var expandMode: Any = "icon"
  var level: Any = 1
  var node: Any? = nil
  var selectedIds: Any = [] as [Any]
  var selectionMode: Any = "none"
  var isExpanded: Any { specIncludes(expandedIds, specGet(node, "id")) }
  var isSelected: Any { specIncludes(selectedIds, specGet(node, "id")) }
  var hasChildren: Any { (!specIsNil(specGet(node, "children")) && (specGt(specLength(specGet(node, "children")), 0)) as? Bool ?? false) }
  var toggleIcon: Any { ((isExpanded) as? Bool ?? false ? "▾" : "▸") }
  func handleToggle() {
    if specEq(expandMode, "icon") {
      dispatch("toggle", [specGet(node, "id")] as [Any])
    }
  }
  func handleSelect() {
    if (specNeq(specGet(node, "disabled"), true) && specNeq(selectionMode, "none")) {
      dispatch("select", [specGet(node, "id")] as [Any])
    }
  }
  func handleRowClick() {
    if specEq(expandMode, "row") {
      if (hasChildren) as? Bool ?? false {
        dispatch("toggle", [specGet(node, "id")] as [Any])
      } else {
        handleSelect()
      }
    } else {
      handleSelect()
    }
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct TreeNodeView: View {
  @State private var vm = TreeNodeViewModel()
  var expandedIds: Any = [] as [Any]
  var expandMode: Any = "icon"
  var level: Any = 1
  var node: Any? = nil
  var selectedIds: Any = [] as [Any]
  var selectionMode: Any = "none"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(expandedIds: Any = [] as [Any], expandMode: Any = "icon", level: Any = 1, node: Any? = nil, selectedIds: Any = [] as [Any], selectionMode: Any = "none", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TreeNodeViewModel(); _m.expandedIds = expandedIds; _m.expandMode = expandMode; _m.level = level; _m.node = node; _m.selectedIds = selectedIds; _m.selectionMode = selectionMode; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.expandedIds = expandedIds; self.expandMode = expandMode; self.level = level; self.node = node; self.selectedIds = selectedIds; self.selectionMode = selectionMode; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(expandedIds) + "\u{1}" + specChangeKey(expandMode) + "\u{1}" + specChangeKey(level) + "\u{1}" + specChangeKey(node) + "\u{1}" + specChangeKey(selectedIds) + "\u{1}" + specChangeKey(selectionMode) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        Button(action: { specClick { vm.handleRowClick() } }) {
        HStack(alignment: .center, spacing: 0) {
          if (vm.hasChildren) as? Bool ?? false {
          Button(action: { specClick { vm.handleToggle() } }) {
          VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: specString(vm.toggleIcon))
              .font(.body)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
              .foregroundStyle(ThemeManager.shared.color("text-secondary"))
          }
          .frame(width: CGFloat(20), alignment: .leading)
          .frame(minWidth: CGFloat(20), alignment: .leading)
            .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
          }
          if specEq(vm.hasChildren, false) {
          VStack(alignment: .leading, spacing: 0) {
          }
          .frame(width: CGFloat(20), alignment: .leading)
          .frame(minWidth: CGFloat(20), alignment: .leading)
          }
          if !specIsNil(specGet(vm.node, "icon")) {
          HStack(alignment: .center, spacing: 0) {
            if !specIsNil(specGet(vm.node, "icon")) {
              Group {
                if !specString((!specIsNil(specGet(vm.node, "icon")) ? specGet(vm.node, "icon") : "")).trimmingCharacters(in: .whitespaces).isEmpty {
                  Image(systemName: specIconName(specString((!specIsNil(specGet(vm.node, "icon")) ? specGet(vm.node, "icon") : ""))))
                    .font(.system(size: specPx(16)))
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                }
              }
            }
          }
          .frame(width: CGFloat(20), alignment: .center)
          .frame(minWidth: CGFloat(20), alignment: .center)
          }
          Text(verbatim: specString(specGet(vm.node, "label")))
            .font(({ () -> Font? in switch specString(((vm.isSelected) as? Bool ?? false ? "body-md-strong" : "body-md")) { case "display-lg": return Font.largeTitle.weight(.bold); case "display-md": return Font.largeTitle.weight(.bold); case "heading-xl": return Font.largeTitle.weight(.bold); case "heading-lg": return Font.largeTitle.weight(.bold); case "heading-md": return Font.title.weight(.semibold); case "heading-sm": return Font.title2.weight(.semibold); case "heading-xs": return Font.title3.weight(.semibold); case "body-lg": return Font.title3; case "body-md": return Font.body; case "body-sm": return Font.footnote; case "caption": return Font.caption2; case "label-lg": return Font.title3.weight(.medium); case "label-md": return Font.body.weight(.medium); case "label-sm": return Font.footnote.weight(.medium); case "label-xs": return Font.caption2.weight(.medium); case "button-sm": return Font.subheadline.weight(.medium); case "mono-lg": return Font.title3; case "mono-md": return Font.body; case "mono-sm": return Font.footnote; case "body-lg-strong": return Font.title3.weight(.semibold); case "body-md-strong": return Font.body.weight(.semibold); case "body-sm-strong": return Font.footnote.weight(.semibold); case "caption-strong": return Font.caption2.weight(.semibold); case "label-lg-strong": return Font.title3.weight(.semibold); case "label-md-strong": return Font.body.weight(.semibold); case "label-sm-strong": return Font.footnote.weight(.semibold); case "label-xs-strong": return Font.caption2.weight(.semibold); case "mono-lg-strong": return Font.title3.weight(.semibold); case "mono-md-strong": return Font.body.weight(.semibold); case "mono-sm-strong": return Font.footnote.weight(.semibold); default: return nil } })())
            .foregroundStyle(((vm.isSelected) as? Bool ?? false ? ThemeManager.shared.color("interactive") : ThemeManager.shared.color("text-primary")))
        }
        .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-1")))
        .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-1")))
        .opacity(specPx((specEq(specGet(vm.node, "disabled"), true) ? 0.5 : 1)))
        .hoverEffect(.highlight)
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        if ((vm.isExpanded) as? Bool ?? false && (vm.hasChildren) as? Bool ?? false) {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(Array(specArr(specGet(vm.node, "children")).enumerated()), id: \.offset) { _idx, child in
            TreeNodeView(expandedIds: vm.expandedIds, expandMode: vm.expandMode, level: specAdd(vm.level, 1), node: child, selectedIds: vm.selectedIds, selectionMode: vm.selectionMode, onDispatch: { specEvent, specPayload in
              _ = specPayload
              switch specString(specEvent) {
              case "toggle":
                let specArgs = specArr(specPayload)
                let id: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
                vm.dispatch("toggle", [id] as [Any])
              case "select":
                let specArgs = specArr(specPayload)
                let id: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
                vm.dispatch("select", [id] as [Any])
              default: break
              }
            })
          }
        }
        .padding(.leading, CGFloat(20))
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.expandedIds = expandedIds
      vm.expandMode = expandMode
      vm.level = level
      vm.node = node
      vm.selectedIds = selectedIds
      vm.selectionMode = selectionMode
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.node, node) { vm.node = node }; if !specSame(vm.level, level) { vm.level = level }; if !specSame(vm.expandedIds, expandedIds) { vm.expandedIds = expandedIds }; if !specSame(vm.selectedIds, selectedIds) { vm.selectedIds = selectedIds }; if !specSame(vm.selectionMode, selectionMode) { vm.selectionMode = selectionMode }; if !specSame(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
    .task(id: specPropsKey([node, level, expandedIds, selectedIds, selectionMode, expandMode])) { if !specSame(vm.node, node) { vm.node = node }; if !specSame(vm.level, level) { vm.level = level }; if !specSame(vm.expandedIds, expandedIds) { vm.expandedIds = expandedIds }; if !specSame(vm.selectedIds, selectedIds) { vm.selectedIds = selectedIds }; if !specSame(vm.selectionMode, selectionMode) { vm.selectionMode = selectionMode }; if !specSame(vm.expandMode, expandMode) { vm.expandMode = expandMode } }
  }
}
