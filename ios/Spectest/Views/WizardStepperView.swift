import SwiftUI
import SpecRuntime

@Observable
@MainActor
final class WizardStepperViewModel {
  var currentStep: Any = "info"
  @ObservationIgnored var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
  func _specTakeDispatch(_ f: ((_ event: Any, _ payload: Any?) -> Void)?) { onDispatch = f }
}

struct WizardStepperView: View {
  @State private var vm = WizardStepperViewModel()
  var currentStep: Any = "info"
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil
  init(currentStep: Any = "info", onDispatch: ((_ event: Any, _ payload: Any?) -> Void)? = nil) { let _m = WizardStepperViewModel(); _m.currentStep = currentStep; _m.onDispatch = onDispatch; self._vm = State(initialValue: _m); self.currentStep = currentStep; self.onDispatch = onDispatch }
  private var _specParamKey: String { specChangeKey(currentStep) }
  var body: some View {
    let _ = vm._specTakeDispatch(onDispatch)
    VStack(alignment: .leading, spacing: 0) {
      StepperView(activeStep: vm.currentStep, orientation: "horizontal", steps: [["id": "info" as Any, "label": "Basic Info" as Any, "description": "Title & assignee" as Any] as [String: Any], ["id": "options" as Any, "label": "Options" as Any, "description": "Priority & dates" as Any] as [String: Any], ["id": "review" as Any, "label": "Review" as Any, "description": "Confirm details" as Any] as [String: Any], ["id": "done" as Any, "label": "Done" as Any, "description": "Task created" as Any] as [String: Any]] as [Any])
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .onChange(of: _specParamKey) { _, _ in
      vm.onDispatch = onDispatch
      vm.currentStep = currentStep
    }
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { vm.onDispatch = onDispatch }
    .onAppear { if !specSame(vm.currentStep, currentStep) { vm.currentStep = currentStep } }
    .task(id: specPropsKey([currentStep])) { if !specSame(vm.currentStep, currentStep) { vm.currentStep = currentStep } }
  }
}
