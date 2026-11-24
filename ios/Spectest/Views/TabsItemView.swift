import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class TabsItemViewModel {
  var active: Any = false
  var countTone: Any = "state"
  var divider: Any = false
  var fillColumn: Any = true
  var focused: Any = false
  var labelNoWrap: Any = false
  var labelScale: Any = ""
  var size: Any = "md"
  var tab: Any? = nil
  var tabStop: Any = true
  var variant: Any = "pill"
  var padY: Any { (specEq(variant, "segmented") ? (specEq(size, "sm") ? "1px" : "6px") : (specEq(size, "sm") ? (specEq(variant, "pill") ? "4px" : "5px") : (specEq(variant, "pill") ? "9px" : "10px"))) }
  var padX: Any { (specEq(variant, "segmented") ? "12px" : (specEq(size, "sm") ? (specEq(variant, "pill") ? "10px" : "12px") : (specEq(variant, "pill") ? "12px" : "16px"))) }
  var itemRadius: Any { (specEq(variant, "pill") ? "8px" : (specEq(variant, "segmented") ? "7px" : "0px")) }
  var itemBg: Any { ((specEq(variant, "pill") && (active) as? Bool ?? false) ? ThemeManager.shared.rawToken("interactive-bg") : ((specEq(variant, "segmented") && (active) as? Bool ?? false) ? ThemeManager.shared.rawToken("surface") : "transparent")) }
  var itemShadow: Any { ((specEq(variant, "segmented") && (active) as? Bool ?? false) ? "0 1px 3px rgba(0,0,0,0.12), 0 0 0 0.5px rgba(0,0,0,0.04)" : "none") }
  var itemBorder: Any { ((specEq(variant, "pill") && (active) as? Bool ?? false) ? "1px solid #bfdbfe" : "1px solid transparent") }
  var itemBorderBot: Any { (specEq(variant, "underline") ? ((active) as? Bool ?? false ? specAdd("2px solid ", ThemeManager.shared.rawToken("interactive")) : "2px solid transparent") : ((specEq(variant, "pill") && (active) as? Bool ?? false) ? "1px solid #bfdbfe" : "1px solid transparent")) }
  var hoverBg: Any { ((active) as? Bool ?? false ? (specEq(variant, "pill") ? ThemeManager.shared.rawToken("interactive-bg") : (specEq(variant, "segmented") ? ThemeManager.shared.rawToken("surface") : "transparent")) : (specEq(variant, "segmented") ? "transparent" : ThemeManager.shared.rawToken("surface-hover"))) }
  var fg: Any { ((active) as? Bool ?? false ? (specEq(variant, "segmented") ? ThemeManager.shared.rawToken("text-primary") : ThemeManager.shared.rawToken("interactive-hover")) : ThemeManager.shared.rawToken("text-secondary")) }
  var iconFg: Any { ((active) as? Bool ?? false ? (specEq(variant, "segmented") ? ThemeManager.shared.rawToken("text-primary") : ThemeManager.shared.rawToken("interactive-hover")) : ThemeManager.shared.rawToken("text-tertiary")) }
  var countText: Any { (!specIsNil(specGet(tab, "count")) ? specString(specGet(tab, "count")) : "") }
  var countBg: Any { (specEq(countTone, "strong") ? ThemeManager.shared.rawToken("tab-countStrongBg") : ((active) as? Bool ?? false ? ThemeManager.shared.rawToken("interactive-bg") : ThemeManager.shared.rawToken("surface-hover"))) }
  var countFg: Any { (specEq(countTone, "strong") ? ThemeManager.shared.rawToken("tab-countStrongColor") : ((active) as? Bool ?? false ? ThemeManager.shared.rawToken("interactive-hover") : ThemeManager.shared.rawToken("text-tertiary"))) }
  var tabStopOrder: Any { ((tabStop) as? Bool ?? false ? "0" : "-1") }
  var labelWhiteSpace: Any { ((labelNoWrap) as? Bool ?? false ? "nowrap" : "") }
  var labelFontSize: Any { labelScale }
  var itemWidth: Any { ((fillColumn) as? Bool ?? false ? "100%" : "auto") }
  var itemBorderRight: Any { ((divider) as? Bool ?? false ? specAdd("1px solid ", ThemeManager.shared.rawToken("border")) : "none") }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct TabsItemView: View {
  @State private var vm = TabsItemViewModel()
  var active: Any = false
  var countTone: Any = "state"
  var divider: Any = false
  var fillColumn: Any = true
  var focused: Any = false
  var labelNoWrap: Any = false
  var labelScale: Any = ""
  var size: Any = "md"
  var tab: Any? = nil
  var tabStop: Any = true
  var variant: Any = "pill"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(active: Any = false, countTone: Any = "state", divider: Any = false, fillColumn: Any = true, focused: Any = false, labelNoWrap: Any = false, labelScale: Any = "", size: Any = "md", tab: Any? = nil, tabStop: Any = true, variant: Any = "pill", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = TabsItemViewModel(); _m.active = active; _m.countTone = countTone; _m.divider = divider; _m.fillColumn = fillColumn; _m.focused = focused; _m.labelNoWrap = labelNoWrap; _m.labelScale = labelScale; _m.size = size; _m.tab = tab; _m.tabStop = tabStop; _m.variant = variant; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.active = active; self.countTone = countTone; self.divider = divider; self.fillColumn = fillColumn; self.focused = focused; self.labelNoWrap = labelNoWrap; self.labelScale = labelScale; self.size = size; self.tab = tab; self.tabStop = tabStop; self.variant = variant; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(active) + "\u{1}" + specChangeKey(countTone) + "\u{1}" + specChangeKey(divider) + "\u{1}" + specChangeKey(fillColumn) + "\u{1}" + specChangeKey(focused) + "\u{1}" + specChangeKey(labelNoWrap) + "\u{1}" + specChangeKey(labelScale) + "\u{1}" + specChangeKey(size) + "\u{1}" + specChangeKey(tab) + "\u{1}" + specChangeKey(tabStop) + "\u{1}" + specChangeKey(variant) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      Button(action: { specClick { Task { @MainActor in await vm.dispatch("change", [specGet(vm.tab, "id")] as [Any]) } } }) {
        HStack(alignment: .center, spacing: CGFloat(8)) {
          if !specIsNil(specGet(vm.tab, "icon")) {
          VStack(alignment: .leading, spacing: 0) {
            if !specIsNil(specGet(vm.tab, "icon")) {
              Group {
                if !specString(specGet(vm.tab, "icon")).trimmingCharacters(in: .whitespaces).isEmpty {
                  Image(systemName: specIconName(specString(specGet(vm.tab, "icon"))))
                    .font(.system(size: specPx(14)))
                    .foregroundStyle(Color(hex: vm.iconFg as? String ?? "transparent"))
                }
              }
            }
          }

          }
          Text(verbatim: specString(specGet(vm.tab, "label")))
            .font(.system(size: specPx(vm.labelFontSize)))
            .foregroundStyle(Color(hex: vm.fg as? String ?? "transparent"))
          if !specIsNil(specGet(vm.tab, "count")) {
          HStack(alignment: .center, spacing: 0) {
            Text(verbatim: specString(vm.countText))
              .font(.caption2)
              .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-xs-strong-fontWeight")))
              .foregroundStyle(Color(hex: vm.countFg as? String ?? "transparent"))
          }
          .padding(.leading, CGFloat(6))
          .padding(.trailing, CGFloat(6))
          .specFrameHeight(CGFloat(18), alignment: .center)
          .background(Color(hex: vm.countBg as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: CGFloat(9)))
          .clipShape(RoundedRectangle(cornerRadius: CGFloat(9)))
          }
        }
        .padding(.trailing, specBorderWidth(vm.itemBorderRight))
        .padding(.bottom, specBorderWidth(vm.itemBorderBot))
        .padding(.top, specBorderWidth(vm.itemBorder))
        .padding(.bottom, specBorderShorthandWidth(vm.itemBorder, unless: vm.itemBorderBot))
        .padding(.leading, specBorderWidth(vm.itemBorder))
        .padding(.trailing, specBorderShorthandWidth(vm.itemBorder, unless: vm.itemBorderRight))
        .padding(.leading, specPx(vm.padX))
        .padding(.trailing, specPx(vm.padX))
        .padding(.top, specPx(vm.padY))
        .padding(.bottom, specPx(vm.padY))
        .specFrameWidth(vm.itemWidth, alignment: .center)
        .background(Color(hex: vm.itemBg as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: specPx(vm.itemRadius)))
        .specBorderSides(vm.itemBorder, top: nil, right: vm.itemBorderRight, bottom: vm.itemBorderBot, left: nil, radius: specPx(vm.itemRadius))
        .specBoxShadow(vm.itemShadow, radius: specPx(vm.itemRadius))
        .accessibilityAddTraits(specAriaChecked(vm.active) ? .isSelected : [])
        .hoverEffect(.highlight)
        .contentShape(Rectangle())
      }
      .buttonStyle(.plain)
      .specFullBasis(specString(vm.itemWidth) == "100%")
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .specFullBasis(specString(vm.itemWidth) == "100%")
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.active = active
      vm.countTone = countTone
      vm.divider = divider
      vm.fillColumn = fillColumn
      vm.focused = focused
      vm.labelNoWrap = labelNoWrap
      vm.labelScale = labelScale
      vm.size = size
      vm.tab = tab
      vm.tabStop = tabStop
      vm.variant = variant
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.tab, tab) { vm.tab = tab }; if !specSame(vm.active, active) { vm.active = active }; if !specSame(vm.variant, variant) { vm.variant = variant }; if !specSame(vm.tabStop, tabStop) { vm.tabStop = tabStop }; if !specSame(vm.focused, focused) { vm.focused = focused }; if !specSame(vm.countTone, countTone) { vm.countTone = countTone }; if !specSame(vm.size, size) { vm.size = size }; if !specSame(vm.fillColumn, fillColumn) { vm.fillColumn = fillColumn }; if !specSame(vm.divider, divider) { vm.divider = divider }; if !specSame(vm.labelScale, labelScale) { vm.labelScale = labelScale }; if !specSame(vm.labelNoWrap, labelNoWrap) { vm.labelNoWrap = labelNoWrap } }
    .task(id: specPropsKey([tab, active, variant, tabStop, focused, countTone, size, fillColumn, divider, labelScale, labelNoWrap])) { if !specSame(vm.tab, tab) { vm.tab = tab }; if !specSame(vm.active, active) { vm.active = active }; if !specSame(vm.variant, variant) { vm.variant = variant }; if !specSame(vm.tabStop, tabStop) { vm.tabStop = tabStop }; if !specSame(vm.focused, focused) { vm.focused = focused }; if !specSame(vm.countTone, countTone) { vm.countTone = countTone }; if !specSame(vm.size, size) { vm.size = size }; if !specSame(vm.fillColumn, fillColumn) { vm.fillColumn = fillColumn }; if !specSame(vm.divider, divider) { vm.divider = divider }; if !specSame(vm.labelScale, labelScale) { vm.labelScale = labelScale }; if !specSame(vm.labelNoWrap, labelNoWrap) { vm.labelNoWrap = labelNoWrap } }
  }
}
