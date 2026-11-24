import Foundation

func gridRowOpacity(_ row: Any = Optional<Any>.none as Any) -> Any? {
  let row = (row as? [String: Any]) ?? [:]
  if !specIsNil(specGet(row, "_opacity")) {
    return specGet(row, "_opacity")
  }
  return 1.0
}
