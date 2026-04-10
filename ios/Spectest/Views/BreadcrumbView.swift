import SwiftUI
import SpecRuntime

@Observable
final class BreadcrumbViewModel {
  var items: Any? = nil
  var maxVisible: Any = 0
  var separator: Any = "/"
  var expanded: Any = false
  func expand() {
    expanded = true
  }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct BreadcrumbView: View {
  @State private var vm = BreadcrumbViewModel()
  var items: Any? = nil
  var maxVisible: Any = 0
  var separator: Any = "/"
  init(items: Any? = nil, maxVisible: Any = 0, separator: Any = "/") { self._vm = State(initialValue: BreadcrumbViewModel()); self.items = items; self.maxVisible = maxVisible; self.separator = separator }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(4)) {
        ForEach(Array((vm.items as? [Any] ?? []).enumerated()), id: \.offset) { index, item in
          VStack() {
            if ((specDouble(index) > specDouble(0)) && ((((vm.expanded as? Bool ?? false || (specString(vm.maxVisible) == specString(0))) || (specDouble(specLength(vm.items)) <= specDouble(vm.maxVisible)) as? Bool ?? false) || (specString(index) == specString(1))) || (specDouble(index) >= specDouble(specAdd((specDouble(specLength(vm.items)) - specDouble(vm.maxVisible)), 1))) as? Bool ?? false)) {
              Text(specString(vm.separator))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }

          VStack() {
            if (((!(vm.expanded as? Bool ?? false) && (specDouble(vm.maxVisible) > specDouble(0))) && (specDouble(specLength(vm.items)) > specDouble(vm.maxVisible))) && (specString(index) == specString(1))) {
              Text(specString("u2026"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }
          }

          .onTapGesture { vm.expand() }
          VStack() {
            if ((specString(index) != specString((specDouble(specLength(vm.items)) - specDouble(1)))) && ((((vm.expanded as? Bool ?? false || (specString(vm.maxVisible) == specString(0))) || (specDouble(specLength(vm.items)) <= specDouble(vm.maxVisible)) as? Bool ?? false) || (specString(index) == specString(0))) || (specDouble(index) >= specDouble(specAdd((specDouble(specLength(vm.items)) - specDouble(vm.maxVisible)), 1))) as? Bool ?? false)) {
              Text(specString((item as? [String: Any])?["label"]))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }
          }

          .onTapGesture { /* event callback */ }
          VStack() {
            if (specString(index) == specString((specDouble(specLength(vm.items)) - specDouble(1)))) {
              Text(specString((item as? [String: Any])?["label"]))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            }
          }

        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.items = items; vm.separator = separator; vm.maxVisible = maxVisible }
  }
}
