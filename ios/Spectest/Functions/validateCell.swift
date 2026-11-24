import Foundation

func validateCell(_ value: Any = Optional<Any>.none as Any, _ column: Any = Optional<Any>.none as Any) -> Any? {
  if (specEq(specGet(column, "required"), true) && (specIsNil(value) || specEq(value, ""))) {
    var label: Any = egColHeading(column)
    return "\(specString(label)) is required"
  }
  return nil
}
