import Foundation

func _stepMark(_ step: Any = Optional<Any>.none as Any, _ i: Any = Optional<Any>.none as Any, _ activeStep: Any = Optional<Any>.none as Any) -> Any? {
  let step = (step as? [String: Any]) ?? [:]
  let i = specDouble(i)
  let activeStep = specDouble(activeStep)
  var state: Any = _stepState(step, i, activeStep)
  if specEq(state, "complete") {
    return "✓"
  }
  if specEq(state, "skipped") {
    return "–"
  }
  if specEq(state, "incomplete") {
    return "!"
  }
  return specString((i + 1.0))
}
