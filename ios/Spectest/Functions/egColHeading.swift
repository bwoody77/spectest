import Foundation

func egColHeading(_ col: Any = Optional<Any>.none as Any) -> Any? {
  if !specIsNil(specGet(col, "header")) {
    return specGet(col, "header")
  }
  if !specIsNil(specGet(col, "label")) {
    return specGet(col, "label")
  }
  return specGet(col, "key")
}
