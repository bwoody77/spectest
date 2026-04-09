import SwiftUI
import SpecRuntime

@Observable
final class TabsViewModel {
  var activeTab: Any = ""
  var tabs: Any? = nil
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
          LazyVStack(spacing: CGFloat(8)) {
            ForEach(Array((vm.tabs as? [Any] ?? []).enumerated()), id: \.offset) { _idx, tab in
              VStack() {
                Text(specString((tab as? [String: Any])?["label"]))
                  .font(.body.bold())
                  .foregroundStyle(Color(hex: ({ () -> Any in switch specString((specString((tab as? [String: Any])?["id"]) == specString(vm.activeTab))) {
case specString(true): return "#1677ff"
default: return "#496183"
} })() as? String ?? "#000"))
              }
              .padding(CGFloat(12))
              .clipShape(RoundedRectangle(cornerRadius: CGFloat(0)))
              .clipShape(RoundedRectangle(cornerRadius: CGFloat(0)))
              .onTapGesture { /* event callback */ }
            }
          }
          VStack() {
          }
          .frame(minHeight: CGFloat(0))
          .frame(minWidth: CGFloat(0))
          .frame(maxWidth: .infinity)
        }

        VStack() {
          // slot
        }
        .padding(CGFloat(16))
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.tabs = tabs; vm.activeTab = activeTab }
  }
}
