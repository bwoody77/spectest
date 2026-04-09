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
            if (((index as? Double ?? 0) > (0 as? Double ?? 0)) && ((((vm.expanded as? Bool ?? false || (specString(vm.maxVisible) == specString(0))) || ((specLength(vm.items) as? Double ?? 0) <= (vm.maxVisible as? Double ?? 0)) as? Bool ?? false) || (specString(index) == specString(1))) || ((index as? Double ?? 0) >= (specAdd(((specLength(vm.items) as? Double ?? 0) - (vm.maxVisible as? Double ?? 0)), 1) as? Double ?? 0)) as? Bool ?? false)) {
              Text(specString(vm.separator))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }

          VStack() {
            if (((!(vm.expanded as? Bool ?? false) && ((vm.maxVisible as? Double ?? 0) > (0 as? Double ?? 0))) && ((specLength(vm.items) as? Double ?? 0) > (vm.maxVisible as? Double ?? 0))) && (specString(index) == specString(1))) {
              Text(specString("u2026"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }
          }

          .onTapGesture { vm.expand() }
          VStack() {
            if ((specString(index) != specString(((specLength(vm.items) as? Double ?? 0) - (1 as? Double ?? 0)))) && ((((vm.expanded as? Bool ?? false || (specString(vm.maxVisible) == specString(0))) || ((specLength(vm.items) as? Double ?? 0) <= (vm.maxVisible as? Double ?? 0)) as? Bool ?? false) || (specString(index) == specString(0))) || ((index as? Double ?? 0) >= (specAdd(((specLength(vm.items) as? Double ?? 0) - (vm.maxVisible as? Double ?? 0)), 1) as? Double ?? 0)) as? Bool ?? false)) {
              Text(specString((item as? [String: Any])?["label"]))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }
          }

          .onTapGesture { /* event callback */ }
          VStack() {
            if (specString(index) == specString(((specLength(vm.items) as? Double ?? 0) - (1 as? Double ?? 0)))) {
              Text(specString((item as? [String: Any])?["label"]))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
            }
          }

        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.items = items; vm.separator = separator; vm.maxVisible = maxVisible }
  }
}
