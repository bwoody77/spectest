import SwiftUI
import SpecRuntime

@Observable
final class TimelineViewModel {
  var items: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct TimelineView: View {
  @State private var vm = TimelineViewModel()
  var items: Any? = nil
  init(items: Any? = nil) { self._vm = State(initialValue: TimelineViewModel()); self.items = items }
  var body: some View {
    VStack() {
      VStack() {
        ForEach(Array(specArr(vm.items).enumerated()), id: \.offset) { index, item in
          HStack(alignment: .center) {
            VStack() {
              VStack() {
              }
              .frame(width: CGFloat(12))
              .specFrameHeight(CGFloat(12))
              .frame(minWidth: CGFloat(12))
              .frame(minHeight: CGFloat(12))
              .background(({ () -> Color in switch specString(specGet(item, "status")) {
case specString("completed"): return Color(hex: "#22c55e")
case specString("active"): return Color(hex: "#3b82f6")
case specString("error"): return Color(hex: "#ef4444")
default: return Color(hex: "#9ca3af")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
              VStack() {
                if specNeq(index, (specDouble(specLength(vm.items)) - specDouble(1))) {
                }
              }
              .background(({ () -> Color in switch specString(specGet(item, "status")) {
case specString("completed"): return Color(hex: "#22c55e")
case specString("active"): return Color(hex: "#3b82f6")
case specString("error"): return Color(hex: "#ef4444")
default: return Color(hex: "#d1d5db")
} })())
              .frame(width: CGFloat(2))
              .frame(minWidth: CGFloat(2))
              .frame(minHeight: CGFloat(24))
              .background(({ () -> Color in switch specString(specGet(item, "status")) {
case specString("completed"): return Color(hex: "#22c55e")
case specString("active"): return Color(hex: "#3b82f6")
case specString("error"): return Color(hex: "#ef4444")
default: return Color(hex: "#d1d5db")
} })())
              .frame(maxWidth: .infinity)
            }
            .frame(width: CGFloat(24))
            .frame(minWidth: CGFloat(24))
            VStack(spacing: CGFloat(2)) {
              VStack() {
                if specNeq(specGet(item, "date"), "") {
                  Text(verbatim: specString(specGet(item, "date")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                }
              }

              Text(verbatim: specString(specGet(item, "title")))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("text-primary"))
              VStack() {
                if specNeq(specGet(item, "description"), "") {
                  Text(verbatim: specString(specGet(item, "description")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("text-secondary"))
                }
              }

            }
            .padding(ThemeManager.shared.size("spacing-2"))
            .frame(maxWidth: .infinity)
          }

        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.items, items) { vm.items = items } }
    .task(id: specPropsKey([items])) { if !specEq(vm.items, items) { vm.items = items } }
  }
}
