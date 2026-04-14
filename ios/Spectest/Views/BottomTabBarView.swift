import SwiftUI
import SpecRuntime

@Observable
final class BottomTabBarViewModel {
  var activeTab: Any = ""
  var showLabels: Any = true
  var tabs: Any = [] as [Any]
  func selectTab(_ tabId: Any) {
    /* event callback */
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct BottomTabBarView: View {
  @State private var vm = BottomTabBarViewModel()
  var activeTab: Any = ""
  var showLabels: Any = true
  var tabs: Any = [] as [Any]
  init(activeTab: Any = "", showLabels: Any = true, tabs: Any = [] as [Any]) { self._vm = State(initialValue: BottomTabBarViewModel()); self.activeTab = activeTab; self.showLabels = showLabels; self.tabs = tabs }
  var body: some View {
    VStack() {
      HStack(alignment: .center) {
        ForEach(Array(specArr(vm.tabs).enumerated()), id: \.offset) { _idx, tab in
          Button(action: { vm.selectTab(specGet(tab, "id")) }) {
          VStack(spacing: CGFloat(2)) {
            Image(systemName: specIconName(specString(specGet(tab, "icon"))))
              .font(.system(size: specPx("22px")))
              .foregroundStyle((specEq(vm.activeTab, specGet(tab, "id")) ? ThemeManager.shared.color("accent") : ThemeManager.shared.color("text-tertiary")))
            Text(verbatim: specString(specGet(tab, "label")))
              .font(.body.bold())
              .foregroundStyle((specEq(vm.activeTab, specGet(tab, "id")) ? ThemeManager.shared.color("accent") : ThemeManager.shared.color("text-tertiary")))
            VStack() {
              if specEq(vm.activeTab, specGet(tab, "id")) {
              }
            }
            .frame(width: CGFloat(24))
            .specFrameHeight(CGFloat(2))
            .background(ThemeManager.shared.color("accent"), in: RoundedRectangle(cornerRadius: CGFloat(1)))
          }
          .padding(.top, ThemeManager.shared.size("spacing-2"))
          .padding(.bottom, ThemeManager.shared.size("spacing-1"))
          .frame(maxWidth: .infinity)
          .hoverEffect(.highlight)
          }
          .buttonStyle(.plain)
        }
      }
      .background(ThemeManager.shared.color("surface"))
      .background(ThemeManager.shared.color("surface"))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.tabs, tabs) { vm.tabs = tabs }; if !specEq(vm.activeTab, activeTab) { vm.activeTab = activeTab }; if !specEq(vm.showLabels, showLabels) { vm.showLabels = showLabels } }
    .task(id: specPropsKey([tabs, activeTab, showLabels])) { if !specEq(vm.tabs, tabs) { vm.tabs = tabs }; if !specEq(vm.activeTab, activeTab) { vm.activeTab = activeTab }; if !specEq(vm.showLabels, showLabels) { vm.showLabels = showLabels } }
  }
}
