import SwiftUI
import SpecRuntime

@Observable
final class WizardStepperViewModel {
  var currentStep: Any? = nil
  var onDispatch: ((_ event: Any, _ payload: Any?) -> Void)?
  func dispatch(_ event: Any, _ payload: Any? = nil) { onDispatch?(event, payload) }
}

struct WizardStepperView: View {
  @State private var vm = WizardStepperViewModel()
  var currentStep: Any? = nil
  init(currentStep: Any? = nil) { self._vm = State(initialValue: WizardStepperViewModel()); self.currentStep = currentStep }
  var body: some View {
    VStack() {
      StepperView(activeStep: vm.currentStep, orientation: "horizontal", steps: [["id": "info" as Any, "label": "Basic Info" as Any, "description": "Title & assignee" as Any] as [String: Any], ["id": "options" as Any, "label": "Options" as Any, "description": "Priority & dates" as Any] as [String: Any], ["id": "review" as Any, "label": "Review" as Any, "description": "Confirm details" as Any] as [String: Any], ["id": "done" as Any, "label": "Done" as Any, "description": "Task created" as Any] as [String: Any]] as [Any])
    }
    .foregroundStyle(ThemeManager.shared.color("text-primary"))
    .environment(\.font, ThemeManager.shared.themeFont())
    .fontDesign(ThemeManager.shared.fontDesign())
    .onAppear { if !specEq(vm.currentStep, currentStep) { vm.currentStep = currentStep } }
    .task(id: specPropsKey([currentStep])) { if !specEq(vm.currentStep, currentStep) { vm.currentStep = currentStep } }
  }
}
