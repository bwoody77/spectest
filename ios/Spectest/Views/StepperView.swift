import SwiftUI
import SpecRuntime

@Observable
final class StepperViewModel {
  var activeStep: Any = 0
  var allowBack: Any = true
  var orientation: Any = "horizontal"
  var steps: Any = [] as [Any]
  var stepCount: Any { specLength(steps) }
  func dispatch(_ event: Any, _ payload: Any? = nil) {}
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
        if specEq(vm.orientation, "horizontal") {
          ForEach(Array(specArr(vm.steps).enumerated()), id: \.offset) { i, step in
            HStack(alignment: .center, ) {
              Button(action: { if ((vm.allowBack) as? Bool ?? false && (specDouble(i) < specDouble(vm.activeStep))) {
  /* event callback */
} }) {
              VStack(spacing: CGFloat(4)) {
                HStack(alignment: .center, ) {
                  Text(verbatim: specString(({ () -> Any in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return "u2713"
default: return "\(specString(specAdd(i, 1)))"
} })()))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: ({ () -> Any in switch specString(true) {
case specString((specDouble(i) <= specDouble(vm.activeStep))): return "#ffffff"
default: return "#496183"
} })() as? String ?? "transparent"))
                }
                .frame(width: CGFloat(32))
                .specFrameHeight(CGFloat(32))
                .frame(minWidth: CGFloat(32))
                .background(Color(hex: ({ () -> Any in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return "#22c55e"
case specString(specEq(i, vm.activeStep)): return "#1677ff"
default: return "#ffffff"
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
                Text(verbatim: specString(specGet(step, "label")))
                  .font(.body.bold())
                  .foregroundStyle(Color(hex: ({ () -> Any in switch specString(true) {
case specString(specEq(i, vm.activeStep)): return "#202732"
case specString((specDouble(i) < specDouble(vm.activeStep))): return "#22c55e"
default: return "#92a2b9"
} })() as? String ?? "transparent"))
              }

              }
              .buttonStyle(.plain)
              VStack() {
                if (specDouble(i) < specDouble((specDouble(vm.stepCount) - specDouble(1)))) {
                }
              }
              .background(Color(hex: ((specDouble(i) < specDouble(vm.activeStep)) ? "#22c55e" : "#dce0e5") as? String ?? "transparent"))
              .specFrameHeight(CGFloat(2))
              .frame(minHeight: CGFloat(2))
              .background(Color(hex: ((specDouble(i) < specDouble(vm.activeStep)) ? "#22c55e" : "#dce0e5") as? String ?? "transparent"))
              .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
          }
        }
      }

      VStack() {
        if specEq(vm.orientation, "vertical") {
          ForEach(Array(specArr(vm.steps).enumerated()), id: \.offset) { i, step in
            HStack(alignment: .center, spacing: CGFloat(12)) {
              VStack() {
                Button(action: { if ((vm.allowBack) as? Bool ?? false && (specDouble(i) < specDouble(vm.activeStep))) {
  /* event callback */
} }) {
                HStack(alignment: .center, ) {
                  Text(verbatim: specString(({ () -> Any in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return "u2713"
default: return "\(specString(specAdd(i, 1)))"
} })()))
                    .font(.body.bold())
                    .foregroundStyle(Color(hex: ({ () -> Any in switch specString(true) {
case specString((specDouble(i) <= specDouble(vm.activeStep))): return "#ffffff"
default: return "#496183"
} })() as? String ?? "transparent"))
                }
                .frame(width: CGFloat(32))
                .specFrameHeight(CGFloat(32))
                .frame(minWidth: CGFloat(32))
                .background(Color(hex: ({ () -> Any in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return "#22c55e"
case specString(specEq(i, vm.activeStep)): return "#1677ff"
default: return "#ffffff"
} })() as? String ?? "transparent"), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
                }
                .buttonStyle(.plain)
                VStack() {
                  if (specDouble(i) < specDouble((specDouble(vm.stepCount) - specDouble(1)))) {
                  }
                }
                .background(Color(hex: ((specDouble(i) < specDouble(vm.activeStep)) ? "#22c55e" : "#dce0e5") as? String ?? "transparent"))
                .frame(width: CGFloat(2))
                .frame(minHeight: CGFloat(24))
                .background(Color(hex: ((specDouble(i) < specDouble(vm.activeStep)) ? "#22c55e" : "#dce0e5") as? String ?? "transparent"))
                .frame(maxWidth: .infinity)
              }
              .frame(width: CGFloat(32))
              .frame(minWidth: CGFloat(32))
              VStack(spacing: CGFloat(4)) {
                Text(verbatim: specString(specGet(step, "label")))
                  .font(.body.bold())
                  .foregroundStyle(Color(hex: ({ () -> Any in switch specString(true) {
case specString(specEq(i, vm.activeStep)): return "#202732"
case specString((specDouble(i) < specDouble(vm.activeStep))): return "#22c55e"
default: return "#92a2b9"
} })() as? String ?? "transparent"))
                VStack() {
                  if specGet(step, "description") != nil {
                    Text(verbatim: specString(specGet(step, "description")))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("semantic.border-strong"))
                  }
                }

              }
              .padding(CGFloat(8))
            }

          }
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("semantic.text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.steps, steps) { vm.steps = steps }; if !specEq(vm.activeStep, activeStep) { vm.activeStep = activeStep }; if !specEq(vm.orientation, orientation) { vm.orientation = orientation }; if !specEq(vm.allowBack, allowBack) { vm.allowBack = allowBack } }
    .task(id: specPropsKey([steps, activeStep, orientation, allowBack])) { if !specEq(vm.steps, steps) { vm.steps = steps }; if !specEq(vm.activeStep, activeStep) { vm.activeStep = activeStep }; if !specEq(vm.orientation, orientation) { vm.orientation = orientation }; if !specEq(vm.allowBack, allowBack) { vm.allowBack = allowBack } }
  }
}
