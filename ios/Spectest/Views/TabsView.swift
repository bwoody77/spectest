import SwiftUI
import SpecRuntime

@Observable
final class TabsViewModel {
  var activeTab: Any = ""
  var tabs: Any? = nil
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct TabsView: View {
  @State private var vm = TabsViewModel()
  var activeTab: Any = ""
  var tabs: Any? = nil
  init(activeTab: Any = "", tabs: Any? = nil) { self._vm = State(initialValue: TabsViewModel()); self.activeTab = activeTab; self.tabs = tabs }
  var body: some View {
    VStack() {
      VStack() {
        HStack(alignment: .center, spacing: CGFloat(0)) {
          ForEach(Array(specArr(vm.tabs).enumerated()), id: \.offset) { _idx, tab in
            Button(action: { /* event callback */ }) {
            VStack() {
              Text(verbatim: specString(specGet(tab, "label")))
                .font(.body.bold())
                .foregroundStyle(Color(hex: ({ () -> Any in switch specString(specEq(specGet(tab, "id"), vm.activeTab)) {
case specString(true): return "#1677ff"
default: return "#496183"
} })() as? String ?? "transparent"))
            }
            .padding(CGFloat(12))
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(0)))
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(0)))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
          }
          VStack() {
          }
          .frame(maxWidth: .infinity)
        }

        VStack() {
          // slot
        }
        .padding(CGFloat(16))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.tabs, tabs) { vm.tabs = tabs }; if !specEq(vm.activeTab, activeTab) { vm.activeTab = activeTab } }
    .task(id: specPropsKey([tabs, activeTab])) { if !specEq(vm.tabs, tabs) { vm.tabs = tabs }; if !specEq(vm.activeTab, activeTab) { vm.activeTab = activeTab } }
  }
}
