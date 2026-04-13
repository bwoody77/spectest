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
        ForEach(Array(specArr(vm.items).enumerated()), id: \.offset) { index, item in
          VStack() {
            if ((specDouble(index) > specDouble(0)) && (((((vm.expanded) as? Bool ?? false || specEq(vm.maxVisible, 0)) || (specDouble(specLength(vm.items)) <= specDouble(vm.maxVisible))) || specEq(index, 1)) || (specDouble(index) >= specDouble(specAdd((specDouble(specLength(vm.items)) - specDouble(vm.maxVisible)), 1))))) {
              Text(verbatim: specString(vm.separator))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
            }
          }

          VStack() {
            if (((((!((vm.expanded) as? Bool ?? false))) as? Bool ?? false && (specDouble(vm.maxVisible) > specDouble(0))) && (specDouble(specLength(vm.items)) > specDouble(vm.maxVisible))) && specEq(index, 1)) {
              Text(verbatim: specString("u2026"))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }
          }

          .onTapGesture { vm.expand() }
          VStack() {
            if (specNeq(index, (specDouble(specLength(vm.items)) - specDouble(1))) && (((((vm.expanded) as? Bool ?? false || specEq(vm.maxVisible, 0)) || (specDouble(specLength(vm.items)) <= specDouble(vm.maxVisible))) || specEq(index, 0)) || (specDouble(index) >= specDouble(specAdd((specDouble(specLength(vm.items)) - specDouble(vm.maxVisible)), 1))))) {
              Text(verbatim: specString(specGet(item, "label")))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.accent"))
            }
          }

          .onTapGesture { /* event callback */ }
          VStack() {
            if specEq(index, (specDouble(specLength(vm.items)) - specDouble(1))) {
              Text(verbatim: specString(specGet(item, "label")))
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
    .onAppear { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.separator, separator) { vm.separator = separator }; if !specEq(vm.maxVisible, maxVisible) { vm.maxVisible = maxVisible } }
    .task(id: specPropsKey([items, separator, maxVisible])) { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.separator, separator) { vm.separator = separator }; if !specEq(vm.maxVisible, maxVisible) { vm.maxVisible = maxVisible } }
  }
}
