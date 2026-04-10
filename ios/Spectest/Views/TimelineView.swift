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
        ForEach(Array((vm.items as? [Any] ?? []).enumerated()), id: \.offset) { index, item in
          HStack(alignment: .center, ) {
            VStack() {
              VStack() {
              }
              .frame(width: CGFloat(12))
              .frame(height: CGFloat(12))
              .frame(minWidth: CGFloat(12))
              .frame(minHeight: CGFloat(12))
              .background(Color(hex: ({ () -> Any in switch specString((item as? [String: Any])?["status"]) {
case specString("completed"): return "#22c55e"
case specString("active"): return "#3b82f6"
case specString("error"): return "#ef4444"
default: return "#9ca3af"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
              VStack() {
                if (specString(index) != specString((specDouble(specLength(vm.items)) - specDouble(1)))) {
                }
              }
              .background(Color(hex: ({ () -> Any in switch specString((item as? [String: Any])?["status"]) {
case specString("completed"): return "#22c55e"
case specString("active"): return "#3b82f6"
case specString("error"): return "#ef4444"
default: return "#d1d5db"
} })() as? String ?? "#000"))
              .frame(minHeight: CGFloat(0))
              .frame(minWidth: CGFloat(0))
              .frame(width: CGFloat(2))
              .frame(minWidth: CGFloat(2))
              .frame(minHeight: CGFloat(24))
              .background(Color(hex: ({ () -> Any in switch specString((item as? [String: Any])?["status"]) {
case specString("completed"): return "#22c55e"
case specString("active"): return "#3b82f6"
case specString("error"): return "#ef4444"
default: return "#d1d5db"
} })() as? String ?? "#000"))
              .frame(maxWidth: .infinity)
            }
            .frame(width: CGFloat(24))
            .frame(minWidth: CGFloat(24))
            VStack(spacing: CGFloat(2)) {
              VStack() {
                if (specString((item as? [String: Any])?["date"]) != specString("")) {
                  Text(specString((item as? [String: Any])?["date"]))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                }
              }

              Text(specString((item as? [String: Any])?["title"]))
                .font(.body.bold())
                .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
              VStack() {
                if (specString((item as? [String: Any])?["description"]) != specString("")) {
                  Text(specString((item as? [String: Any])?["description"]))
                    .font(.body.bold())
                    .foregroundStyle(ThemeManager.shared.color("semantic.text-secondary"))
                }
              }

            }
            .padding(CGFloat(8))
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
          }

        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.items = items }
  }
}
