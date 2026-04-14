import SwiftUI
import SpecRuntime

@Observable
final class StepperViewModel {
  var activeStep: Any = 0
  var allowBack: Any = true
  var orientation: Any = "horizontal"
  var steps: Any = [] as [Any]
  var stepCount: Any { specLength(steps) }
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
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
      HStack(alignment: .center) {
        if specEq(vm.orientation, "horizontal") {
          ForEach(Array(specArr(vm.steps).enumerated()), id: \.offset) { i, step in
            HStack(alignment: .center) {
              Button(action: { if ((vm.allowBack) as? Bool ?? false && (specDouble(i) < specDouble(vm.activeStep))) {
  /* event callback */
} }) {
              VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                HStack(alignment: .center) {
                  Text(verbatim: specString(({ () -> Any in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return "u2713"
default: return "\(specString(specAdd(i, 1)))"
} })()))
                    .font(.body.bold())
                    .foregroundStyle(({ () -> Color in switch specString(true) {
case specString((specDouble(i) <= specDouble(vm.activeStep))): return ThemeManager.shared.color("semantic.background")
default: return ThemeManager.shared.color("text-secondary")
} })())
                }
                .frame(width: CGFloat(32))
                .specFrameHeight(CGFloat(32))
                .frame(minWidth: CGFloat(32))
                .background(({ () -> Color in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return Color(hex: "#22c55e")
case specString(specEq(i, vm.activeStep)): return ThemeManager.shared.color("interactive")
default: return ThemeManager.shared.color("surface-raised")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
                Text(verbatim: specString(specGet(step, "label")))
                  .font(.body.bold())
                  .foregroundStyle(({ () -> Color in switch specString(true) {
case specString(specEq(i, vm.activeStep)): return ThemeManager.shared.color("text-primary")
case specString((specDouble(i) < specDouble(vm.activeStep))): return Color(hex: "#22c55e")
default: return ThemeManager.shared.color("text-tertiary")
} })())
              }

              }
              .buttonStyle(.plain)
              VStack() {
                if (specDouble(i) < specDouble((specDouble(vm.stepCount) - specDouble(1)))) {
                }
              }
              .background(((specDouble(i) < specDouble(vm.activeStep)) ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
              .specFrameHeight(CGFloat(2))
              .frame(minHeight: CGFloat(2))
              .background(((specDouble(i) < specDouble(vm.activeStep)) ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
              .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
          }
        }
      }

      VStack() {
        if specEq(vm.orientation, "vertical") {
          ForEach(Array(specArr(vm.steps).enumerated()), id: \.offset) { i, step in
            HStack(alignment: .center, spacing: ThemeManager.shared.size("spacing-3")) {
              VStack() {
                Button(action: { if ((vm.allowBack) as? Bool ?? false && (specDouble(i) < specDouble(vm.activeStep))) {
  /* event callback */
} }) {
                HStack(alignment: .center) {
                  Text(verbatim: specString(({ () -> Any in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return "u2713"
default: return "\(specString(specAdd(i, 1)))"
} })()))
                    .font(.body.bold())
                    .foregroundStyle(({ () -> Color in switch specString(true) {
case specString((specDouble(i) <= specDouble(vm.activeStep))): return ThemeManager.shared.color("semantic.background")
default: return ThemeManager.shared.color("text-secondary")
} })())
                }
                .frame(width: CGFloat(32))
                .specFrameHeight(CGFloat(32))
                .frame(minWidth: CGFloat(32))
                .background(({ () -> Color in switch specString(true) {
case specString((specDouble(i) < specDouble(vm.activeStep))): return Color(hex: "#22c55e")
case specString(specEq(i, vm.activeStep)): return ThemeManager.shared.color("interactive")
default: return ThemeManager.shared.color("surface-raised")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
                }
                .buttonStyle(.plain)
                VStack() {
                  if (specDouble(i) < specDouble((specDouble(vm.stepCount) - specDouble(1)))) {
                  }
                }
                .background(((specDouble(i) < specDouble(vm.activeStep)) ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
                .frame(width: CGFloat(2))
                .frame(minHeight: CGFloat(24))
                .background(((specDouble(i) < specDouble(vm.activeStep)) ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
                .frame(maxWidth: .infinity)
              }
              .frame(width: CGFloat(32))
              .frame(minWidth: CGFloat(32))
              VStack(spacing: ThemeManager.shared.size("spacing-1")) {
                Text(verbatim: specString(specGet(step, "label")))
                  .font(.body.bold())
                  .foregroundStyle(({ () -> Color in switch specString(true) {
case specString(specEq(i, vm.activeStep)): return ThemeManager.shared.color("text-primary")
case specString((specDouble(i) < specDouble(vm.activeStep))): return Color(hex: "#22c55e")
default: return ThemeManager.shared.color("text-tertiary")
} })())
                VStack() {
                  if specGet(step, "description") != nil {
                    Text(verbatim: specString(specGet(step, "description")))
                      .font(.body.bold())
                      .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
                  }
                }

              }
              .padding(ThemeManager.shared.size("spacing-2"))
            }

          }
        }
      }

    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.steps, steps) { vm.steps = steps }; if !specEq(vm.activeStep, activeStep) { vm.activeStep = activeStep }; if !specEq(vm.orientation, orientation) { vm.orientation = orientation }; if !specEq(vm.allowBack, allowBack) { vm.allowBack = allowBack } }
    .task(id: specPropsKey([steps, activeStep, orientation, allowBack])) { if !specEq(vm.steps, steps) { vm.steps = steps }; if !specEq(vm.activeStep, activeStep) { vm.activeStep = activeStep }; if !specEq(vm.orientation, orientation) { vm.orientation = orientation }; if !specEq(vm.allowBack, allowBack) { vm.allowBack = allowBack } }
  }
}
