import SwiftUI
import SpecRuntime

@Observable
final class BadgeViewModel {
  var text: Any? = nil
  var variant: Any = "neutral"
}

struct BadgeView: View {
  @State private var vm = BadgeViewModel()
  var text: Any? = nil
  var variant: Any = "neutral"
  init(text: Any? = nil, variant: Any = "neutral") { self._vm = State(initialValue: BadgeViewModel()); self.text = text; self.variant = variant }
  var body: some View {
    VStack() {
      HStack(alignment: .center, spacing: CGFloat(4)) {
        Text(specString(vm.text))
          .font(.body.bold())
          .foregroundStyle(Color(hex: ({ () -> Any in switch specString(vm.variant) {
case specString("info"): return "#3b82f6"
case specString("success"): return "#10b981"
case specString("warning"): return "#f59e0b"
case specString("error"): return "#ef4444"
case specString("neutral"): return "#64748b"
default: return "#64748b"
} })() as? String ?? "#000"))
      }
      .padding(.leading, CGFloat(10))
      .padding(.trailing, CGFloat(10))
      .padding(.top, CGFloat(2))
      .padding(.bottom, CGFloat(2))
      .background(Color(hex: ({ () -> Any in switch specString(vm.variant) {
case specString("info"): return "#eff6ff"
case specString("success"): return "#ecfdf5"
case specString("warning"): return "#fffbeb"
case specString("error"): return "#fef2f2"
case specString("neutral"): return "#f1f5f9"
default: return "#f1f5f9"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.text = text; vm.variant = variant }
  }
}
