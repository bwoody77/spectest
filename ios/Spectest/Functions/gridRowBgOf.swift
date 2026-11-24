import Foundation

func gridRowBgOf(_ row: Any = Optional<Any>.none as Any) -> Any? {
  let row = (row as? [String: Any]) ?? [:]
  if !specIsNil(specGet(row, "_bg")) {
    return specGet(row, "_bg")
  }
  return ""
}
