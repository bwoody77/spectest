import SwiftUI
import SpecRuntime

@Observable
final class AccordionViewModel {
  var items: Any? = nil
  var multiple: Any = false
  var openIds: Any = [] as [Any]
  func toggle(_ id: Any) {
    openIds = ({ () -> Any in switch specString(specIncludes(openIds, id)) {
case specString(true): return specFilter(openIds, { (x: Any) -> Bool in return specNeq(x, id) })
default: return ({ () -> Any in switch specString(multiple) {
case specString(true): return specConcat(openIds, [id] as [Any])
default: return [id] as [Any]
} })()
} })()
    /* event callback */
  }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct AccordionView: View {
  @State private var vm = AccordionViewModel()
  var items: Any? = nil
  var multiple: Any = false
  init(items: Any? = nil, multiple: Any = false) { self._vm = State(initialValue: AccordionViewModel()); self.items = items; self.multiple = multiple }
  var body: some View {
    VStack() {
      VStack() {
        ForEach(Array(specArr(vm.items).enumerated()), id: \.offset) { _idx, item in
          VStack() {
            Button(action: { vm.toggle(specGet(item, "id")) }) {
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-2")) {
              Text(verbatim: specString(specGet(item, "title")))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              Text(verbatim: specString(({ () -> Any in switch specString(specIncludes(vm.openIds, specGet(item, "id"))) {
case specString(true): return "−"
default: return "+"
} })()))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
            }
            .padding(ThemeManager.shared.size("spacing-3"))
            .background(ThemeManager.shared.color("surface"))
            .background(ThemeManager.shared.color("surface"))
            .hoverEffect(.highlight)
            }
            .buttonStyle(.plain)
            VStack() {
              VStack() {
                Text(verbatim: specString(specGet(item, "content")))
                  .font(.body.bold())
                  .foregroundStyle(ThemeManager.shared.color("text-secondary"))
              }
              .padding(ThemeManager.shared.size("spacing-3"))
            }
            .frame(maxHeight: specPx(({ () -> Any in switch specString(specIncludes(vm.openIds, specGet(item, "id"))) {
case specString(true): return "500px"
default: return "0"
} })()))
          }

        }
      }
      .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
      .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("md")))
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.multiple, multiple) { vm.multiple = multiple } }
    .task(id: specPropsKey([items, multiple])) { if !specEq(vm.items, items) { vm.items = items }; if !specEq(vm.multiple, multiple) { vm.multiple = multiple } }
  }
}
