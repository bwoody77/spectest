import Foundation

func gridBodyKey(_ row: Any = Optional<Any>.none as Any, _ keyField: Any = Optional<Any>.none as Any) -> Any? {
  let keyField = specString(keyField)
  if !specIsNil(specGet(row, "_rk")) {
    return ("p:" + specString(specGet(row, "_rk")))
  }
  if specEq(specGet(row, "_unloaded"), true) {
    return ("u:" + specString(specGet(row, "_slot")))
  }
  return ("k:" + specString(specGet(row, keyField)))
}
