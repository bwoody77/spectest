import Foundation

func _stepState(_ step: Any = Optional<Any>.none as Any, _ i: Any = Optional<Any>.none as Any, _ activeStep: Any = Optional<Any>.none as Any) -> Any? {
  let step = (step as? [String: Any]) ?? [:]
  let i = specDouble(i)
  let activeStep = specDouble(activeStep)
  if (i == activeStep) {
    return "current"
  }
  var declared: Any = specGet(step, "status")
  if specEq(declared, "complete") {
    return "complete"
  }
  if specEq(declared, "skipped") {
    return "skipped"
  }
  if specEq(declared, "incomplete") {
    return "incomplete"
  }
  if (i < activeStep) {
    return "complete"
  }
  return "upcoming"
}
