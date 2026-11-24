import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class StepperViewModel {
  var activeStep: Any = 0
  var allowBack: Any = true
  var orientation: Any = "horizontal"
  var steps: Any = [] as [Any]
  var stepCount: Any { specLength(steps) }
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct StepperView: View {
  @State private var vm = StepperViewModel()
  var activeStep: Any = 0
  var allowBack: Any = true
  var orientation: Any = "horizontal"
  var steps: Any = [] as [Any]
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(activeStep: Any = 0, allowBack: Any = true, orientation: Any = "horizontal", steps: Any = [] as [Any], onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = StepperViewModel(); _m.activeStep = activeStep; _m.allowBack = allowBack; _m.orientation = orientation; _m.steps = steps; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.activeStep = activeStep; self.allowBack = allowBack; self.orientation = orientation; self.steps = steps; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(activeStep) + "\u{1}" + specChangeKey(allowBack) + "\u{1}" + specChangeKey(orientation) + "\u{1}" + specChangeKey(steps) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      if specEq(vm.orientation, "horizontal") {
        _specArm0
      }
      if specEq(vm.orientation, "vertical") {
        _specArm1
      }
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.activeStep = activeStep
      vm.allowBack = allowBack
      vm.orientation = orientation
      vm.steps = steps
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.steps, steps) { vm.steps = steps }; if !specSame(vm.activeStep, activeStep) { vm.activeStep = activeStep }; if !specSame(vm.orientation, orientation) { vm.orientation = orientation }; if !specSame(vm.allowBack, allowBack) { vm.allowBack = allowBack } }
    .task(id: specPropsKey([steps, activeStep, orientation, allowBack])) { if !specSame(vm.steps, steps) { vm.steps = steps }; if !specSame(vm.activeStep, activeStep) { vm.activeStep = activeStep }; if !specSame(vm.orientation, orientation) { vm.orientation = orientation }; if !specSame(vm.allowBack, allowBack) { vm.allowBack = allowBack } }
  }

  private var _specArm0: AnyView {
    AnyView(Group {
      HStack(alignment: .center, spacing: 0) {
        ForEach(Array(specArr(vm.steps).enumerated()), id: \.offset) { i, step in
          HStack(alignment: .center, spacing: 0) {
            Button(action: { specClick { if ((vm.allowBack) as? Bool ?? false && (specLt(i, vm.activeStep)) as? Bool ?? false) {
  vm.dispatch("change", [i] as [Any])
} } }) {
            VStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              HStack(alignment: .center, spacing: 0) {
                Spacer(minLength: 0)
                Text(verbatim: specString(_stepMark(step, i, vm.activeStep)))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(({ () -> Color in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("upcoming"): return ThemeManager.shared.color("text-secondary")
case specString("skipped"): return ThemeManager.shared.color("text-secondary")
case specString("incomplete"): return ThemeManager.shared.color("text-primary")
default: return ThemeManager.shared.color("background")
} })())
                Spacer(minLength: 0)
              }
              .frame(maxWidth: .infinity)
              .padding(specBorderWidth(({ () -> Any in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("upcoming"): return ThemeManager.shared.rawToken("borders-default")
default: return "2px solid transparent"
} })()))
              .frame(width: CGFloat(32), alignment: .center)
              .specFrameHeight(CGFloat(32), alignment: .center)
              .frame(minWidth: CGFloat(32), alignment: .center)
              .background(({ () -> Color in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("current"): return ThemeManager.shared.color("interactive")
case specString("complete"): return Color(hex: "#22c55e")
case specString("skipped"): return ThemeManager.shared.color("border")
case specString("incomplete"): return ThemeManager.shared.color("warning")
default: return ThemeManager.shared.color("surface-raised")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
              .specBorderAll(({ () -> Any in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("upcoming"): return ThemeManager.shared.rawToken("borders-default")
default: return "2px solid transparent"
} })(), radius: ThemeManager.shared.radius("full"))
              .accessibilityElement(children: .ignore)
              .specAriaLabel(_stepName(step, i, vm.stepCount, vm.activeStep))
              .accessibilityAddTraits(specAriaOn((specEq(i, vm.activeStep) ? "step" : "false")) ? .isSelected : [])
              Text(verbatim: specString(specGet(step, "label")))
                .font(.footnote)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                .foregroundStyle(({ () -> Color in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("current"): return ThemeManager.shared.color("text-primary")
case specString("complete"): return Color(hex: "#22c55e")
case specString("incomplete"): return ThemeManager.shared.color("warning-text")
default: return ThemeManager.shared.color("text-tertiary")
} })())
            }

              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            if (specLt(i, (specDouble(vm.stepCount) - specDouble(1)))) as? Bool ?? false {
            VStack(alignment: .leading, spacing: 0) {
            }
            .specFrameHeight(CGFloat(2), alignment: .top)
            .frame(minHeight: CGFloat(2), alignment: .top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(((_stepDone(step, i, vm.activeStep)) as? Bool ?? false ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
            .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
            .specFlexGrow(1)
            }
          }
          .frame(maxWidth: .infinity, alignment: .center)
          .specFlexGrow(1)
        }
      }
      .accessibilityElement(children: .contain)
      .accessibilityLabel(specString("Progress steps"))
    })
  }

  private var _specArm1: AnyView {
    AnyView(Group {
      VStack(alignment: .leading, spacing: 0) {
        ForEach(Array(specArr(vm.steps).enumerated()), id: \.offset) { i, step in
          HStack(alignment: .center, spacing: specPx(ThemeManager.shared.rawToken("spacing-3"))) {
            VStack(alignment: .center, spacing: 0) {
              Button(action: { specClick { if ((vm.allowBack) as? Bool ?? false && (specLt(i, vm.activeStep)) as? Bool ?? false) {
  vm.dispatch("change", [i] as [Any])
} } }) {
              HStack(alignment: .center, spacing: 0) {
                Spacer(minLength: 0)
                Text(verbatim: specString(_stepMark(step, i, vm.activeStep)))
                  .font(.footnote)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-label-sm-fontWeight")))
                  .foregroundStyle(({ () -> Color in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("upcoming"): return ThemeManager.shared.color("text-secondary")
case specString("skipped"): return ThemeManager.shared.color("text-secondary")
case specString("incomplete"): return ThemeManager.shared.color("text-primary")
default: return ThemeManager.shared.color("background")
} })())
                Spacer(minLength: 0)
              }
              .frame(maxWidth: .infinity)
              .padding(specBorderWidth(({ () -> Any in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("upcoming"): return ThemeManager.shared.rawToken("borders-default")
default: return "2px solid transparent"
} })()))
              .frame(width: CGFloat(32), alignment: .center)
              .specFrameHeight(CGFloat(32), alignment: .center)
              .frame(minWidth: CGFloat(32), alignment: .center)
              .background(({ () -> Color in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("current"): return ThemeManager.shared.color("interactive")
case specString("complete"): return Color(hex: "#22c55e")
case specString("skipped"): return ThemeManager.shared.color("border")
case specString("incomplete"): return ThemeManager.shared.color("warning")
default: return ThemeManager.shared.color("surface-raised")
} })(), in: RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
              .clipShape(RoundedRectangle(cornerRadius: ThemeManager.shared.radius("full")))
              .specBorderAll(({ () -> Any in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("upcoming"): return ThemeManager.shared.rawToken("borders-default")
default: return "2px solid transparent"
} })(), radius: ThemeManager.shared.radius("full"))
              .accessibilityElement(children: .ignore)
              .specAriaLabel(_stepName(step, i, vm.stepCount, vm.activeStep))
              .accessibilityAddTraits(specAriaOn((specEq(i, vm.activeStep) ? "step" : "false")) ? .isSelected : [])
                .contentShape(Rectangle())
              }
              .buttonStyle(.plain)
              if (specLt(i, (specDouble(vm.stepCount) - specDouble(1)))) as? Bool ?? false {
              VStack(alignment: .leading, spacing: 0) {
              }
              .frame(width: CGFloat(2), alignment: .leading)
              .frame(minHeight: CGFloat(24), alignment: .top)
              .frame(maxHeight: .infinity, alignment: .leading)
              .background(((_stepDone(step, i, vm.activeStep)) as? Bool ?? false ? Color(hex: "#22c55e") : ThemeManager.shared.color("border")))
              .specFlexGrow(1)
              }
            }
            .frame(width: CGFloat(32), alignment: .center)
            .frame(minWidth: CGFloat(32), alignment: .center)
            VStack(alignment: .leading, spacing: specPx(ThemeManager.shared.rawToken("spacing-1"))) {
              Text(verbatim: specString(specGet(step, "label")))
                .font(.body)
                .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-body-md-fontWeight")))
                .foregroundStyle(({ () -> Color in switch specString(_stepState(step, i, vm.activeStep)) {
case specString("current"): return ThemeManager.shared.color("text-primary")
case specString("complete"): return Color(hex: "#22c55e")
case specString("incomplete"): return ThemeManager.shared.color("warning-text")
default: return ThemeManager.shared.color("text-tertiary")
} })())
              if !specIsNil(specGet(step, "description")) {
              VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: specString(specGet(step, "description")))
                  .font(.caption2)
                  .fontWeight(specFontWeight(ThemeManager.shared.resolve("type-caption-fontWeight")))
                  .foregroundStyle(ThemeManager.shared.color("text-tertiary"))
              }

              }
            }
            .padding(specPx(ThemeManager.shared.rawToken("spacing-2")))
          }

        }
      }
      .accessibilityElement(children: .contain)
      .accessibilityLabel(specString("Progress steps"))
    })
  }
}
