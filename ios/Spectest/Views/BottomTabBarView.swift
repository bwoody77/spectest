import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class BottomTabBarViewModel {
  var activeTab: Any = ""
  var ariaLabel: Any = ""
  var raisedTabId: Any = ""
  var showLabels: Any = true
  var tabs: Any = [] as [Any]
  func selectTab(_ tabId: Any) {
    dispatch("tabChange", [tabId] as [Any])
  }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct BottomTabBarView: View {
  @State private var vm = BottomTabBarViewModel()
  var activeTab: Any = ""
  var ariaLabel: Any = ""
  var raisedTabId: Any = ""
  var showLabels: Any = true
  var tabs: Any = [] as [Any]
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(activeTab: Any = "", ariaLabel: Any = "", raisedTabId: Any = "", showLabels: Any = true, tabs: Any = [] as [Any], onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = BottomTabBarViewModel(); _m.activeTab = activeTab; _m.ariaLabel = ariaLabel; _m.raisedTabId = raisedTabId; _m.showLabels = showLabels; _m.tabs = tabs; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.activeTab = activeTab; self.ariaLabel = ariaLabel; self.raisedTabId = raisedTabId; self.showLabels = showLabels; self.tabs = tabs; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(activeTab) + "\u{1}" + specChangeKey(ariaLabel) + "\u{1}" + specChangeKey(raisedTabId) + "\u{1}" + specChangeKey(showLabels) + "\u{1}" + specChangeKey(tabs) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .center, spacing: 0) {
        ForEach(Array(specArr(vm.tabs).enumerated()), id: \.offset) { _idx, tab in
          Button(action: { specClick { Task { @MainActor in await vm.selectTab(specGet(tab, "id")) } } }) {
            VStack(alignment: .center, spacing: CGFloat(2)) {
              if (specNeq(vm.raisedTabId, "") && specEq(vm.raisedTabId, specGet(tab, "id"))) {
              HStack(alignment: .center, spacing: 0) {
                if (specNeq(vm.raisedTabId, "") && specEq(vm.raisedTabId, specGet(tab, "id"))) {
                  Group {
                    if !specString(specGet(tab, "icon")).trimmingCharacters(in: .whitespaces).isEmpty {
                      Image(systemName: specIconName(specString(specGet(tab, "icon"))))
                        .font(.system(size: specPx("26px")))
                        .foregroundStyle((specEq(vm.activeTab, specGet(tab, "id")) ? ThemeManager.shared.color("on-interactive") : ThemeManager.shared.color("text-tertiary")))
                    }
                  }
                }
              }
              .padding(specBorderWidth(specAdd("3px solid ", ThemeManager.shared.rawToken("surface"))))
              .frame(width: CGFloat(56), alignment: .center)
              .specFrameHeight(CGFloat(56), alignment: .center)
              .background((specEq(vm.activeTab, specGet(tab, "id")) ? ThemeManager.shared.color("accent") : ThemeManager.shared.color("surface-hover")), in: RoundedRectangle(cornerRadius: CGFloat(999)))
              .clipShape(RoundedRectangle(cornerRadius: CGFloat(999)))
              .specBorderAll(specAdd("3px solid ", ThemeManager.shared.rawToken("surface")), radius: CGFloat(999))
              .specBoxShadow((specEq(vm.activeTab, specGet(tab, "id")) ? ThemeManager.shared.rawToken("elevation-floating") : ThemeManager.shared.rawToken("elevation-raised")), radius: CGFloat(999))
              }
              if (!((specNeq(vm.raisedTabId, "") && specEq(vm.raisedTabId, specGet(tab, "id"))))) {
              VStack(alignment: .leading, spacing: 0) {
                if (!((specNeq(vm.raisedTabId, "") && specEq(vm.raisedTabId, specGet(tab, "id"))))) {
                  Group {
                    if !specString(specGet(tab, "icon")).trimmingCharacters(in: .whitespaces).isEmpty {
                      Image(systemName: specIconName(specString(specGet(tab, "icon"))))
                        .font(.system(size: specPx("22px")))
                        .foregroundStyle((specEq(vm.activeTab, specGet(tab, "id")) ? ThemeManager.shared.color("accent") : ThemeManager.shared.color("text-tertiary")))
                    }
                  }
                }
              }

              }
              if specEq(vm.showLabels, true) {
              Text(verbatim: specString(specGet(tab, "label")))
                .font(.caption2)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                .foregroundStyle((specEq(vm.activeTab, specGet(tab, "id")) ? ThemeManager.shared.color("accent") : ThemeManager.shared.color("text-tertiary")))
              }
            }
            .padding(.top, specPx(ThemeManager.shared.rawToken("spacing-2")))
            .padding(.bottom, specPx(ThemeManager.shared.rawToken("spacing-1")))
            .frame(maxWidth: .infinity, alignment: .center)
            .accessibilityAddTraits(specAriaOn((specEq(vm.activeTab, specGet(tab, "id")) ? "page" : Optional<Any>.none as Any)) ? .isSelected : [])
            .hoverEffect(.highlight)
            .overlay(alignment: .topLeading) {
              ZStack(alignment: .topLeading) {
                if (specEq(vm.activeTab, specGet(tab, "id")) && (!((specNeq(vm.raisedTabId, "") && specEq(vm.raisedTabId, specGet(tab, "id")))))) {
                VStack(alignment: .leading, spacing: 0) {
                }
                .frame(width: CGFloat(24), alignment: .leading)
                .specFrameHeight(CGFloat(2), alignment: .top)
                .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: CGFloat(1)))
                .clipShape(RoundedRectangle(cornerRadius: CGFloat(1)))
                .offset(x: CGFloat(0), y: CGFloat(0))
                }
              }
            }
            .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
          .specAriaLabel(specGet(tab, "label"))
          .specFlexGrow(1)
        }
      }
      .padding(.top, specBorderWidth(ThemeManager.shared.rawToken("borders-default")))
      .background(ThemeManager.shared.color("surface"))
      .specBorderSides(nil, top: ThemeManager.shared.rawToken("borders-default"), right: nil, bottom: nil, left: nil, radius: CGFloat(0))
      .accessibilityElement(children: .contain)
      .specAriaLabel((specNeq(vm.ariaLabel, "") ? vm.ariaLabel : "Primary"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.activeTab = activeTab
      vm.ariaLabel = ariaLabel
      vm.raisedTabId = raisedTabId
      vm.showLabels = showLabels
      vm.tabs = tabs
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.tabs, tabs) { vm.tabs = tabs }; if !specSame(vm.activeTab, activeTab) { vm.activeTab = activeTab }; if !specSame(vm.showLabels, showLabels) { vm.showLabels = showLabels }; if !specSame(vm.ariaLabel, ariaLabel) { vm.ariaLabel = ariaLabel }; if !specSame(vm.raisedTabId, raisedTabId) { vm.raisedTabId = raisedTabId } }
    .task(id: specPropsKey([tabs, activeTab, showLabels, ariaLabel, raisedTabId])) { if !specSame(vm.tabs, tabs) { vm.tabs = tabs }; if !specSame(vm.activeTab, activeTab) { vm.activeTab = activeTab }; if !specSame(vm.showLabels, showLabels) { vm.showLabels = showLabels }; if !specSame(vm.ariaLabel, ariaLabel) { vm.ariaLabel = ariaLabel }; if !specSame(vm.raisedTabId, raisedTabId) { vm.raisedTabId = raisedTabId } }
  }
}
