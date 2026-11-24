import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class PackedTabsViewModel {
  var activeTab: Any = ""
  var countTone: Any = "state"
  var labelScale: Any = ""
  var size: Any = "md"
  var tabs: Any? = nil
  var variant: Any = "pill"
  var focusedId: Any = ""
  var stripBg: Any { (specEq(variant, "pill") ? ThemeManager.shared.rawToken("surface") : "transparent") }
  var stripBorder: Any { (specEq(variant, "pill") ? ThemeManager.shared.rawToken("borders-default") : "1px solid transparent") }
  var stripBorderBot: Any { (specEq(variant, "pill") ? ThemeManager.shared.rawToken("borders-default") : specAdd("1px solid ", ThemeManager.shared.rawToken("border"))) }
  var stripRadius: Any { (specEq(variant, "pill") ? "12px" : "0px") }
  var stripPad: Any { (specEq(variant, "pill") ? "6px" : "0px") }
  var tabStopId: Any { (specNeq(focusedId, "") ? focusedId : activeTab) }
  var tabCount: Any { specLength(tabs) }
  var lastId: Any { ((specGt(tabCount, 0)) as? Bool ?? false ? specGet(specGet(tabs, (specDouble(tabCount) - specDouble(1))), "id") : "") }
  func moveFocus(_ delta: Any) {
    if (specGt(tabCount, 0)) as? Bool ?? false {
      var currentId: Any = (specNeq(focusedId, "") ? focusedId : activeTab)
      var from: Any = _tabIndexOfId(tabs, currentId)
      focusedId = specGet(specGet(tabs, _tabWrap(from, delta, tabCount)), "id")
    }
  }
  func focusEdge(_ last: Any) {
    if (specGt(tabCount, 0)) as? Bool ?? false {
      focusedId = ((last) as? Bool ?? false ? specGet(specGet(tabs, (specDouble(tabCount) - specDouble(1))), "id") : specGet((tabs as? [Any])?[0], "id"))
    }
  }
  func pickTab(_ id: Any) {
    focusedId = id
    dispatch("change", [id] as [Any])
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct PackedTabsView: View {
  @State private var vm = PackedTabsViewModel()
  var activeTab: Any = ""
  var countTone: Any = "state"
  var labelScale: Any = ""
  var size: Any = "md"
  var tabs: Any? = nil
  var variant: Any = "pill"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(activeTab: Any = "", countTone: Any = "state", labelScale: Any = "", size: Any = "md", tabs: Any? = nil, variant: Any = "pill", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = PackedTabsViewModel(); _m.activeTab = activeTab; _m.countTone = countTone; _m.labelScale = labelScale; _m.size = size; _m.tabs = tabs; _m.variant = variant; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.activeTab = activeTab; self.countTone = countTone; self.labelScale = labelScale; self.size = size; self.tabs = tabs; self.variant = variant; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(activeTab) + "\u{1}" + specChangeKey(countTone) + "\u{1}" + specChangeKey(labelScale) + "\u{1}" + specChangeKey(size) + "\u{1}" + specChangeKey(tabs) + "\u{1}" + specChangeKey(variant) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      SpecFlowLayout(spacing: CGFloat(0)) {
        ForEach(Array(specArr(vm.tabs).enumerated()), id: \.offset) { _idx, tab in
          TabsItemView(active: specEq(specGet(tab, "id"), vm.activeTab), countTone: vm.countTone, divider: specNeq(specGet(tab, "id"), vm.lastId), fillColumn: false, focused: specEq(specGet(tab, "id"), vm.focusedId), labelNoWrap: true, labelScale: vm.labelScale, size: vm.size, tab: tab, tabStop: specEq(specGet(tab, "id"), vm.tabStopId), variant: vm.variant, onDispatch: { specEvent, specPayload in
            _ = specPayload
            switch specString(specEvent) {
            case "change":
              let specArgs = specArr(specPayload)
              let id: Any = specArgs.count > 0 ? specArgs[0] : NSNull()
              vm.pickTab(id)
            default: break
            }
          })
        }
      }
      .padding(.bottom, specBorderWidth(vm.stripBorderBot))
      .padding(.top, specBorderWidth(vm.stripBorder))
      .padding(.bottom, specBorderShorthandWidth(vm.stripBorder, unless: vm.stripBorderBot))
      .padding(.leading, specBorderWidth(vm.stripBorder))
      .padding(.trailing, specBorderWidth(vm.stripBorder))
      .specPadding(vm.stripPad)
      .background(Color(hex: vm.stripBg as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(vm.stripRadius)))
      .specBorderSides(vm.stripBorder, top: nil, right: nil, bottom: vm.stripBorderBot, left: nil, radius: specPx(vm.stripRadius))
      .focusable()
      .onKeyPress(.rightArrow) { Task { @MainActor in await vm.moveFocus(1) }; return .handled }
      .onKeyPress(.leftArrow) { Task { @MainActor in await vm.moveFocus(-1) }; return .handled }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.activeTab = activeTab
      vm.countTone = countTone
      vm.labelScale = labelScale
      vm.size = size
      vm.tabs = tabs
      vm.variant = variant
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.tabs, tabs) { vm.tabs = tabs }; if !specSame(vm.activeTab, activeTab) { vm.activeTab = activeTab }; if !specSame(vm.variant, variant) { vm.variant = variant }; if !specSame(vm.countTone, countTone) { vm.countTone = countTone }; if !specSame(vm.size, size) { vm.size = size }; if !specSame(vm.labelScale, labelScale) { vm.labelScale = labelScale } }
    .task(id: specPropsKey([tabs, activeTab, variant, countTone, size, labelScale])) { if !specSame(vm.tabs, tabs) { vm.tabs = tabs }; if !specSame(vm.activeTab, activeTab) { vm.activeTab = activeTab }; if !specSame(vm.variant, variant) { vm.variant = variant }; if !specSame(vm.countTone, countTone) { vm.countTone = countTone }; if !specSame(vm.size, size) { vm.size = size }; if !specSame(vm.labelScale, labelScale) { vm.labelScale = labelScale } }
  }
}
