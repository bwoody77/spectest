import SwiftUI
import SpecRuntime

@Observable
final class StepperViewModel {
  var activeStep: Any = 0
  var allowBack: Any = true
  var orientation: Any = "horizontal"
  var steps: Any = [] as [Any]
  var stepCount: Any { specLength(steps) }
}

struct StepperView: View {
  @State private var vm = StepperViewModel()
  var activeStep: Any = 0
  var allowBack: Any = true
  var orientation: Any = "horizontal"
  var steps: Any = [] as [Any]
  init(activeStep: Any = 0, allowBack: Any = true, orientation: Any = "horizontal", steps: Any = [] as [Any]) { self._vm = State(initialValue: StepperViewModel()); self.activeStep = activeStep; self.allowBack = allowBack; self.orientation = orientation; self.steps = steps }
  var body: some View {
    VStack() {
      HStack(alignment: .center, ) {
        if (specString(vm.orientation) == specString("horizontal")) {
          ForEach(Array((vm.steps as? [Any] ?? []).enumerated()), id: \.offset) { i, step in
            HStack(alignment: .center, ) {
              VStack(spacing: CGFloat(4)) {
                HStack(alignment: .center, ) {
                  Text(specString(({ () -> Any in switch specString(true) {
case specString(((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0))): return "u2713"
default: return "\(specString(specAdd(i, 1)))"
} })()))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: ({ () -> Any in switch specString(true) {
case specString(((i as? Double ?? 0) <= (vm.activeStep as? Double ?? 0))): return "#ffffff"
default: return "#496183"
} })() as? String ?? "#000"))
                }
                .frame(width: CGFloat(32))
                .frame(height: CGFloat(32))
                .frame(minWidth: CGFloat(32))
                .background(Color(hex: ({ () -> Any in switch specString(true) {
case specString(((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0))): return "#22c55e"
case specString((specString(i) == specString(vm.activeStep))): return "#1677ff"
default: return "#ffffff"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(9999)))
                Text(specString((step as? [String: Any])?["label"]))
                  .font(.body.bold())
                  .foregroundStyle(Color(hex: ({ () -> Any in switch specString(true) {
case specString((specString(i) == specString(vm.activeStep))): return "#202732"
case specString(((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0))): return "#22c55e"
default: return "#92a2b9"
} })() as? String ?? "#000"))
              }

              .onTapGesture { if (vm.allowBack as? Bool ?? false && ((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0))) as? Bool ?? false {
  /* event callback */
} }
              VStack() {
                if ((i as? Double ?? 0) < (((vm.stepCount as? Double ?? 0) - (1 as? Double ?? 0)) as? Double ?? 0)) {
                }
              }
              .background(Color(hex: (((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0)) ? "#22c55e" : "#dce0e5") as? String ?? "#000"))
              .frame(minHeight: CGFloat(0))
              .frame(minWidth: CGFloat(0))
              .frame(height: CGFloat(2))
              .frame(minHeight: CGFloat(2))
              .background(Color(hex: (((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0)) ? "#22c55e" : "#dce0e5") as? String ?? "#000"))
              .frame(maxWidth: .infinity)
            }
            .frame(minHeight: CGFloat(0))
            .frame(minWidth: CGFloat(0))
            .frame(maxWidth: .infinity)
          }
        }
      }

      VStack() {
        if (specString(vm.orientation) == specString("vertical")) {
          ForEach(Array((vm.steps as? [Any] ?? []).enumerated()), id: \.offset) { i, step in
            HStack(alignment: .center, spacing: CGFloat(12)) {
              VStack() {
                HStack(alignment: .center, ) {
                  Text(specString(({ () -> Any in switch specString(true) {
case specString(((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0))): return "u2713"
default: return "\(specString(specAdd(i, 1)))"
} })()))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: ({ () -> Any in switch specString(true) {
case specString(((i as? Double ?? 0) <= (vm.activeStep as? Double ?? 0))): return "#ffffff"
default: return "#496183"
} })() as? String ?? "#000"))
                }
                .frame(width: CGFloat(32))
                .frame(height: CGFloat(32))
                .frame(minWidth: CGFloat(32))
                .background(Color(hex: ({ () -> Any in switch specString(true) {
case specString(((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0))): return "#22c55e"
case specString((specString(i) == specString(vm.activeStep))): return "#1677ff"
default: return "#ffffff"
} })() as? String ?? "#000"), in: RoundedRectangle(cornerRadius: CGFloat(9999)))
                .onTapGesture { if (vm.allowBack as? Bool ?? false && ((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0))) as? Bool ?? false {
  /* event callback */
} }
                VStack() {
                  if ((i as? Double ?? 0) < (((vm.stepCount as? Double ?? 0) - (1 as? Double ?? 0)) as? Double ?? 0)) {
                  }
                }
                .background(Color(hex: (((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0)) ? "#22c55e" : "#dce0e5") as? String ?? "#000"))
                .frame(minHeight: CGFloat(0))
                .frame(minWidth: CGFloat(0))
                .frame(width: CGFloat(2))
                .frame(minHeight: CGFloat(24))
                .background(Color(hex: (((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0)) ? "#22c55e" : "#dce0e5") as? String ?? "#000"))
                .frame(maxWidth: .infinity)
              }
              .frame(width: CGFloat(32))
              .frame(minWidth: CGFloat(32))
              VStack(spacing: CGFloat(4)) {
                Text(specString((step as? [String: Any])?["label"]))
                  .font(.body.bold())
                  .foregroundStyle(Color(hex: ({ () -> Any in switch specString(true) {
case specString((specString(i) == specString(vm.activeStep))): return "#202732"
case specString(((i as? Double ?? 0) < (vm.activeStep as? Double ?? 0))): return "#22c55e"
default: return "#92a2b9"
} })() as? String ?? "#000"))
                VStack() {
                  if (step as? [String: Any])?["description"] != nil {
                    Text(specString((step as? [String: Any])?["description"]))
                      .font(.body.bold())
                      .foregroundStyle(.tertiary)
                  }
                }

              }
              .padding(CGFloat(8))
            }

          }
        }
      }

    }
    .foregroundStyle(.primary)
    .onAppear { vm.steps = steps; vm.activeStep = activeStep; vm.orientation = orientation; vm.allowBack = allowBack }
  }
}
