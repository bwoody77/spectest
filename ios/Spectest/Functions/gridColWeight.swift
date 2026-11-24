import Foundation

func gridColWeight(_ col: Any = Optional<Any>.none as Any) -> Any? {
  let col = (col as? [String: Any]) ?? [:]
  if !specIsNil(specGet(col, "width")) {
    return 0.0
  }
  if specTruthy(gridLenIsKeyword(gridColMin(col))) {
    return 0.0
  }
  if (specIsNil(specGet(col, "grow")) || (specTypeOf(specGet(col, "grow")) != "number")) {
    return 1.0
  }
  if specLt(specGet(col, "grow"), 0.0) {
    return 1.0
  }
  return specGet(col, "grow")
}
