import Foundation

func gridRowRail(_ row: Any = Optional<Any>.none as Any) -> Any? {
  let row = (row as? [String: Any]) ?? [:]
  if !specIsNil(specGet(row, "_accent")) {
    return ("inset 3px 0 0 " + specString(specGet(row, "_accent")))
  }
  return "none"
}
