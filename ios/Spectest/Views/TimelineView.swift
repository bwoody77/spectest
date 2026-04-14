import SwiftUI
import SpecRuntime

@Observable
final class TimelineViewModel {
  var items: Any? = nil
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
}

struct TimelineView: View {
  @State private var vm = TimelineViewModel()
  var items: Any? = nil
  init(items: Any? = nil) { self._vm = State(initialValue: TimelineViewModel()); self.items = items }
  var body: some View {
    VStack() {
      VStack() {
        ForEach(Array(specArr(vm.items).enumerated()), id: \.offset) { index, item in
          HStack(alignment: .center, ) {
            VStack() {
              VStack() {
              }
              .frame(width: CGFloat(12))
              .specFrameHeight(CGFloat(12))
              .frame(minWidth: CGFloat(12))
              .frame(minHeight: CGFloat(12))
              .background(Color(hex: ({ () -> Any in switch specString(specGet(item, "status")) {
case specString("completed"): return "#22c55e"
case specString("active"): return "#3b82f6"
case specString("error"): return "#ef4444"
default: return "#9ca3af"
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
              VStack() {
                if specNeq(index, (specDouble(specLength(vm.items)) - specDouble(1))) {
                }
              }
              .background(Color(hex: ({ () -> Any in switch specString(specGet(item, "status")) {
case specString("completed"): return "#22c55e"
case specString("active"): return "#3b82f6"
case specString("error"): return "#ef4444"
default: return "#d1d5db"
} })() as? String ?? "transparent"))
              .frame(width: CGFloat(2))
              .frame(minWidth: CGFloat(2))
              .frame(minHeight: CGFloat(24))
              .background(Color(hex: ({ () -> Any in switch specString(specGet(item, "status")) {
case specString("completed"): return "#22c55e"
case specString("active"): return "#3b82f6"
case specString("error"): return "#ef4444"
default: return "#d1d5db"
} })() as? String ?? "transparent"))
              .frame(maxWidth: .infinity)
            }
            .frame(width: CGFloat(24))
            .frame(minWidth: CGFloat(24))
            VStack(spacing: CGFloat(2)) {
              VStack() {
                if specNeq(specGet(item, "date"), "") {
                  Text(verbatim: specString(specGet(item, "date")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }
              }

              Text(verbatim: specString(specGet(item, "title")))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack() {
                if specNeq(specGet(item, "description"), "") {
                  Text(verbatim: specString(specGet(item, "description")))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                }
              }

            }
            .padding(CGFloat(8))
            .frame(maxWidth: .infinity)
          }

        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.items, items) { vm.items = items } }
    .task(id: specPropsKey([items])) { if !specEq(vm.items, items) { vm.items = items } }
  }
}
