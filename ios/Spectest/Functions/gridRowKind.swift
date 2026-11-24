import Foundation

func gridRowKind(_ row: Any = Optional<Any>.none as Any) -> Any? {
  let row = (row as? [String: Any]) ?? [:]
  if !specIsNil(specGet(row, "_kind")) {
    return specGet(row, "_kind")
  }
  return "row"
}
