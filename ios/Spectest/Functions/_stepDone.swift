import Foundation

func _stepDone(_ step: Any = Optional<Any>.none as Any, _ i: Any = Optional<Any>.none as Any, _ activeStep: Any = Optional<Any>.none as Any) -> Any? {
  let step = (step as? [String: Any]) ?? [:]
  let i = specDouble(i)
  let activeStep = specDouble(activeStep)
  var declared: Any = specGet(step, "status")
  if specEq(declared, "complete") {
    return true
  }
  if specEq(declared, "skipped") {
    return false
  }
  if specEq(declared, "incomplete") {
    return false
  }
  return (i < activeStep)
}
