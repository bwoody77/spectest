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
}

struct BottomTabBarView: View {
  @State private var vm = BottomTabBarViewModel()
  var activeTab: Any = ""
  var showLabels: Any = true
  var tabs: Any = [] as [Any]
  init(activeTab: Any = "", showLabels: Any = true, tabs: Any = [] as [Any]) { self._vm = State(initialValue: BottomTabBarViewModel()); self.activeTab = activeTab; self.showLabels = showLabels; self.tabs = tabs }
  var body: some View {
    VStack() {
      HStack(alignment: .center, ) {
        LazyVStack(spacing: CGFloat(8)) {
          ForEach(Array((vm.tabs as? [Any] ?? []).enumerated()), id: \.offset) { _idx, tab in
            VStack(spacing: CGFloat(2)) {
              Image(systemName: specIconName(specString((tab as? [String: Any])?["icon"])))
                .font(.system(size: specPx("22px")))
                .foregroundStyle(Color(hex: ((specString(vm.activeTab) == specString((tab as? [String: Any])?["id"])) ? "#1677ff" : "#92a2b9") as? String ?? "#000"))
              Text(specString((tab as? [String: Any])?["label"]))
                .font(.body.bold())
                .foregroundStyle(Color(hex: ((specString(vm.activeTab) == specString((tab as? [String: Any])?["id"])) ? "#1677ff" : "#92a2b9") as? String ?? "#000"))
              VStack() {
                if (specString(vm.activeTab) == specString((tab as? [String: Any])?["id"])) {
                }
              }
              .frame(width: CGFloat(24))
              .frame(height: CGFloat(2))
              .background(Color.blue, in: RoundedRectangle(cornerRadius: CGFloat(1)))
            }
            .padding(.top, CGFloat(8))
            .padding(.bottom, CGFloat(4))
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
            .onTapGesture { vm.selectTab((tab as? [String: Any])?["id"]) }
          }
        }
      }
      .padding(.bottom, CGFloat(0))
      .background(Color(.systemGroupedBackground))
      .background(Color(.systemGroupedBackground))
    }
    .foregroundStyle(.primary)
    .onAppear { vm.tabs = tabs; vm.activeTab = activeTab; vm.showLabels = showLabels }
  }
}
