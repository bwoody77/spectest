import Foundation

func _stepName(_ step: Any = Optional<Any>.none as Any, _ i: Any = Optional<Any>.none as Any, _ count: Any = Optional<Any>.none as Any, _ activeStep: Any = Optional<Any>.none as Any) -> Any? {
  let step = (step as? [String: Any]) ?? [:]
  let i = specDouble(i)
  let count = specDouble(count)
  let activeStep = specDouble(activeStep)
  var state: Any = _stepState(step, i, activeStep)
  var word: Any = ("not started" as Any)
  if specEq(state, "current") {
    word = ("current step" as Any)
  }
  if specEq(state, "complete") {
    word = ("completed" as Any)
  }
  if specEq(state, "skipped") {
    word = ("skipped" as Any)
  }
  if specEq(state, "incomplete") {
    word = ("incomplete" as Any)
  }
  var stepNo: Any = ((i + 1.0) as Any)
  return "Step \(specString(stepNo)) of \(specString(count)), \(specString(word))"
}
