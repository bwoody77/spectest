import Foundation

func gridKeysUsable(_ rows: Any = Optional<Any>.none as Any, _ keyField: Any = Optional<Any>.none as Any) -> Any? {
  let rows = specArr(rows)
  let keyField = specString(keyField)
  var seen: Any = (([:] as [String: Any]) as Any)
  for r in rows {
    if (!specIsNil(r) && specNeq(specGet(r, "_unloaded"), true)) {
      var raw: Any = specGet(r, keyField)
      if specIsNil(raw) {
        return false
      }
      var k: Any = (("k:" + specString(raw)) as Any)
      if specEq(specGet(seen, k), true) {
        return false
      }
      seen = specSet(seen, k, (true as Any))
    }
  }
  return true
}
